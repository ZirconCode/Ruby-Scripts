require 'nokogiri'
require 'open-uri'
require 'tactful_tokenizer'


puts 'Enter a Word:'
#word = gets.chomp
word = 'blue'

puts 'Retrieving Rhymes'

doc = Nokogiri::HTML(open('http://wikirhymer.com/words/'+word))

rhymes = doc.to_s.scan(/<!--\[if lte IE 8\]>(.*?)<!\[endif\]-->/im)
rhymes.collect!{|x| x.first.strip}

puts 'Retrieving Sentences'

doc = Nokogiri::HTML(open('https://www.google.com/search?q='+URI::encode(rhymes.sample)))
results = doc.css('h3.r a').collect{|a| a['href'].scan(/url\?q=(.*?)&/).first}


doc  = Nokogiri::HTML(open(results.first.first))

m = TactfulTokenizer::Model.new
pot_sentences = m.tokenize_text(doc.text).collect{|s| s unless s.include?('{')}
# TODO here Clean the text results & continue =)


puts pot_sentences

puts 'Rhyming ^_^/'


