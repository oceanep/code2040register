require 'net/http'
require 'json'
require 'uri'

def connect(url,data)
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
    req.body = data.to_json
    str = http.request(req)
    return str.body
end

def reverse
  data = {token:'b15fb5a5c4987477152bec3f8056bde5'}
  url = 'http://challenge.code2040.org/api/reverse'
  string = connect(url,data)
  string.reverse!
  url = 'http://challenge.code2040.org/api/reverse/validate'
  data = {token:'b15fb5a5c4987477152bec3f8056bde5', string: string}
  response = connect(url,data)
  puts "response #{response}"
end

reverse
