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

def search (needle,haystack)
  haystack.index(needle)
end

data = {token:'b15fb5a5c4987477152bec3f8056bde5'}
response = JSON.parse(connect("http://challenge.code2040.org/api/haystack", data))


needle = response["needle"]
haystack = response["haystack"]

found = search(needle, haystack)

data = {token:'b15fb5a5c4987477152bec3f8056bde5', needle: found}

response = connect("http://challenge.code2040.org/api/haystack/validate",data)

puts "#{response}"
