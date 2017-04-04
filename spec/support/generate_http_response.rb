if ARGV.size != 2
  $stderr.puts "Usage:\t#$0 [URI]", "\tExample: #$0 GET https://api.travis-ci.org/example"
  exit 1
end

require 'http'
response     = HTTP.headers('Accept' => 'application/json', 'Travis-API-Version' => '3').request(ARGV[0], ARGV[1])
keep_headers = %w[Content-Type Location]

puts "#{ARGV[0]} #{ARGV[1]} HTTP/1.1", "Accept: application/json", "Travis-API-Version: 3", "", "HTTP/1.1 #{response.status}"
keep_headers.each do |header|
  next unless response.headers.include? header
  puts "#{header}: #{response.headers[header]}"
end

puts '', response.body
