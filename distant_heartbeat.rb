require 'net/http'
require 'uri'
require 'json'
require 'date'

uri = URI('http://audioapi.orf.at/fm4/json/2.0/playlist/4HE')
res = Net::HTTP.get(uri)

res_json = JSON.parse(res)
puts res_json["streams"][0]["loopStreamId"]

uri = URI("http://loopstream01.apa.at/?channel=fm4&id=" + res_json["streams"][0]["loopStreamId"])
resp = Net::HTTP.get(uri)
open("./hb_" + (Date.today-1).strftime("%d.%m.%Y") + ".mp3", "wb") do |file|
	file.write(resp.body)
end
puts "Done."

#File.write("res.txt", res)
#File.write("res_body.txt", res.body)