require 'net/http'
require 'json'
require 'uri'
require 'time'
require 'date'

def connect(url,data)
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
    req.body = data.to_json
    str = http.request(req)
    str.body
end

data = {token:'b15fb5a5c4987477152bec3f8056bde5'}
response = JSON.parse(connect("http://challenge.code2040.org/api/dating", data))

datestamp = response["datestamp"]
interval = response["interval"]

puts "#{datestamp} #{interval}"

datetime = DateTime.strptime(datestamp, '%Y-%m-%dT%H:%M:%SZ')
datetime += Rational(interval, '86400')
answer = datetime.strftime("%Y-%m-%dT%H:%M:%SZ")

puts "#{datetime}"
puts "#{answer}"

data = {token:'b15fb5a5c4987477152bec3f8056bde5', datestamp: answer}

response = connect("http://challenge.code2040.org/api/dating/validate",data)

puts "#{response}"
