
# Ruby Quiz #1
# Unfinished

input = "Code in Ruby, live longer!"

input.upcase!.gsub!(/[^A-Z]/, '')
input += 'X' while input.length % 5 != 0

a = input.scan(/.{5}/)

('A'..'Z').to_a.each_with_index {|l,i| }

p a
