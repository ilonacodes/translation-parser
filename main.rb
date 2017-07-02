require 'open-uri'
require 'nokogiri'
require 'json'

base_url = ARGV[1]

esp_phrases = []
en_phrases = []

10.times do |page|

  doc = Nokogiri::HTML(open("#{base_url}/#{page+1}/"))
  esp_phrases = esp_phrases.concat(doc.css(".col_a .text").map {|node| node.text})
  en_phrases = en_phrases.concat(doc.css(".col_b .text").map {|node| node.text})

end

phrases = esp_phrases.zip(en_phrases)

phrases = phrases.map {|phrase|
  {
      expression: phrase[0],
      translation: phrase[1],
      language: "ES",
      languageTranslation: "EN"
  }
}
puts JSON.pretty_generate(phrases)

