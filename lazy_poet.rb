

# Makes poetry from random plagiarization
# "The best artists steal"

# example output:

# Ruby
# Had a dark gooey
# of the whole Huey
# Full Definition of SCREWY
# we know that Rubie
# be a true Sufi


# TODO
# so much, parts of speech, syllable count, iambic pentameter and call it shakespeare v2 ;)
# different rhymes, rhythm, patterns, stansas, entire poetry books, insanity
# or make it cite it's source in MLA format


# Script by ZirconCode



require 'tactful_tokenizer'


puts 'Enter a Word:'
word = gets.chomp
#word = 'blue'

puts 'Retrieving Rhymes'

doc = Nokogiri::HTML(open('http://wikirhymer.com/words/'+word))

rhymes = doc.to_s.scan(/<!--\[if lte IE 8\]>(.*?)<!\[endif\]-->/im)
rhymes.collect!{|x| x.first.strip}

puts 'Retrieving Sentences'

rhyme_sentences = []
(0..10).each do |i|

	begin

		rhyme_word = rhymes.sample
		doc = Nokogiri::HTML(open('https://www.google.com/search?q='+URI::encode(rhyme_word)))
		results = doc.css('h3.r a').collect{|a| a['href'].scan(/url\?q=(.*?)&/).first}

		doc  = Nokogiri::HTML(open(results.first.first))

		m = TactfulTokenizer::Model.new
		pot_sentences = m.tokenize_text(doc.text)
		pot_sentences.collect!{|s| s.match(/(\w+\s\w+\s\w+\s#{rhyme_word})/i)} 
		pot_sentences.reject!{|s| s==nil || s.length > 50 }
	
		rhyme_sentences = rhyme_sentences.concat pot_sentences.first 3
	
		puts '.'

	rescue
	  # oh well, enough fish in the sea =)
		puts 'x'
	end
	
end

#puts rhyme_sentences

puts 'Rhyming ^_^/'

puts ''
puts word.capitalize
puts '--'

(0..5).each do |i|
	poem = []
	(0..4).each{|j| poem << rhyme_sentences.sample}
	
	puts poem
	puts '--'
end




