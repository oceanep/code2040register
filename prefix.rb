require 'net/http'
require 'json'
require 'uri'

def connect(url,data)
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
    req.body = data.to_json
    str = http.request(req)
    str.body
end

data = {token:'b15fb5a5c4987477152bec3f8056bde5'}
response = JSON.parse(connect("http://challenge.code2040.org/api/prefix", data))

def search(prefix,array)
  final = []
  array.each do |word|
    final.push(word) unless word.include?(prefix)
  end
  final
end

prefix = response['prefix']
array = response['array']

answer = search(prefix,array)

puts "#{answer}"

data = {token:'b15fb5a5c4987477152bec3f8056bde5', array: answer}

response = connect("http://challenge.code2040.org/api/prefix/validate",data)

puts "#{response}"
