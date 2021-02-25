require 'rubygems'
require 'dotenv/load'
require 'aws-sdk-s3'

bucket = ENV["S3_BUCKET"]
network = ENV["NETWORK"]
chain_path = ENV["CHAIN_PATH"]

s3_endpoint = ENV["S3_ENDPOINT"]

client = Aws::S3::Client.new(
  access_key_id: ENV["S3_ACCESS_KEY"],
  secret_access_key: ENV["S3_SECRET_KEY"],
  endpoint: s3_endpoint,
  region: ENV["S3_REGION"]
)


list_blocks = `find #{chain_path}/blocks -type f`
list_chainstate = `find #{chain_path}/chainstate -type f`


raw_manifest = []
manifest = []

puts "[INFO:] reading chainstate"
list_chainstate.split("\n").each do |lc|
  raw_manifest << {key: lc.gsub("#{chain_path}/", ""), file: lc}
end

puts "[INFO:] reading blocks"
list_blocks.split("\n").each do |lb|
  raw_manifest << {key: lb.gsub("#{chain_path}/", ""), file: lb}
end

puts "[INFO:] starting uploads"
raw_manifest.each do |m|
  puts "[INFO:] uploading #{network}/#{m[:key]}"

  key = "#{network}/#{m[:key]}"

  client.put_object({
    bucket: bucket,
    key: key,
    body: File.read(m[:file]),
    acl: "public-read"
  })

  manifest << ["https://#{bucket}.#{s3_endpoint.gsub("https://", "")}", key].join("/")
end

puts "[INFO:] writing manifest/#{network}.txt"
File.write("manifest/#{network}.txt", manifest.join("\n"))

puts "[INFO:] done :)"