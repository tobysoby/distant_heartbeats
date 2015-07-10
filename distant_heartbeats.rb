require 'net/http'
require 'open-uri'
require 'uri'
require 'json'
require 'date'

uri = URI('http://audioapi.orf.at/fm4/json/2.0/playlist/4HE')
res = Net::HTTP.get(uri)

res_json = JSON.parse(res)
puts res_json["streams"][0]["loopStreamId"]

download = open("http://loopstream01.apa.at/?channel=fm4&id=" + res_json["streams"][0]["loopStreamId"])
IO.copy_stream(download, "./hb_" + (Date.today-1).strftime("%d.%m.%Y") + ".mp3")
puts "Done."