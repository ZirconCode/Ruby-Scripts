

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

rhyme_word = rhymes.sample
doc = Nokogiri::HTML(open('https://www.google.com/search?q='+URI::encode(rhyme_word)))
results = doc.css('h3.r a').collect{|a| a['href'].scan(/url\?q=(.*?)&/).first}


doc  = Nokogiri::HTML(open(results.first.first))

m = TactfulTokenizer::Model.new
pot_sentences = m.tokenize_text(doc.text).collect{|s| s if s.index(/(\w+\s\w+\s\w+\s#{rhyme_word})/i)}
pot_sentences.reject!{|s| s==nil }
# TODO get the regex&tokenizer to give proper results...


puts pot_sentences

puts 'Rhyming ^_^/'
puts rhyme_word


