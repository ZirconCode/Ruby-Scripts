
# Creates NGrams

require 'pp'

def read_file(name)
	f = File.open(name,'r')

	contents = ""
	f.each do |l| 
		contents = contents+l
	end

	f.close

	contents
end

def sanitize(text)
	text.gsub!(/[[^[\w|'|\.|\?|\!|-]]|_]/, ' ')
	text.gsub!('.', ' . ')
	text.gsub!('!', ' ! ')
	text.gsub!('?', ' ? ')
	text.downcase!
	text.squeeze!
end

l = read_file('input.txt') # <--- The Input

l = sanitize(l)

words = Hash.new
w =  l.split(' ')

w.each_index do |i|
	words[w[i].to_sym] = [] if words[w[i].to_sym].nil?
	words[w[i].to_sym] << w[i+1] if (i+1)<w.length
end

#words = words.to_a
#words = words.sort { |x,y| y <=> x }

#pp words

def ngram(sentence,key,words)
	return sentence if sentence.length > 1000
	# can also return after sentence finsihed: .?!
	
	next_word = words[key].sample
	result = sentence+" "+key.to_s+" "
	return result if next_word.nil?
	ngram(result,next_word.to_sym,words)
end


puts ngram("",words.to_a.sample[0],words)

puts "-------"

