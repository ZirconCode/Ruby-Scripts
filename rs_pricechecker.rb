
# ----
# Runescape PriceChecker (flipchat1 prices)
# ----

# Warning: Script runs a headless browser instance, may be slightly heavy

# Scrapes a forumotion forum for certain ingame prices of the MMORPG Runescape
# when trading these, the margins are free ingame money =)
# Prices are saved in a neat JSON "hash"

# by ZirconCode
# ----

require 'watir-webdriver'
require 'nokogiri'
require 'pp'
require 'json'

require 'headless' # requries xvfb to be installed on your system

# --- CONFIGURATION --- preconfigure it when you use it =)
puts 'Please Enter your Name (flipchat1.forumotion.com)'
name = gets.chomp
puts 'Please Enter your Password'
pass = gets.chomp
save = 'rs_data/'

base = 'http://flipchat1.forumotion.com'
# ------------ *w/ temporary e-mail...


def get_likely_link(doc)
	max_likely = -1
	result = nil
	
	doc.xpath('//a').each do |l|
		# TODO MEH.... (DRY it -_-)
		likely = 0
		likely = likely + 2 if l.content.include? Time.now.year.to_s
		likely = likely + 2 if l.content.include? Time.now.year.to_s[2..3]
		likely = likely + 2 if l.content.include? Time.now.month.to_s
		likely = likely + 2 if l.content.include? Time.now.day.to_s
		likely = likely + 1 if l.content.include? (Time.now - 24*60*60).day.to_s
		likely = likely + 1 if l.content.include? 'margin'
		if likely > max_likely
			max_likely = likely
			result = l
		end
	end
	
	result
end


p 'Hello =)'


headless = Headless.new
headless.start
b = Watir::Browser.new

#b.goto 'http://flipchat1.forumotion.com/'
b.goto base+'/login'
b.text_field(:name=>'username').set name
b.text_field(:name=>'password').set pass
b.input(:name=>'login').click

b.goto base+'/f7-margins'

doc = Nokogiri::HTML b.html
link = get_likely_link doc
p 'Best Found: '+link.content
b.goto base+link['href']

doc = Nokogiri::HTML b.html

b.close
headless.destroy

posts = doc.xpath("//div[@class='postbody']")

items = ['bh','bcp','tass','bg','bb','bws',
				 'ah','acp','acs','ag','ab','acb','buck',
				 'hood','garb','gown','sg','sb','ward',
				 'robin','ranger','hiss','murm','sss','bss','elixir']
prices = {}
				
posts.each do |d|
	text = d.content.downcase.gsub("\t",' ')
	m = text.scan(/((#{items.join('|')}).{0,3}\d+\d+.{1,3}\d+\d+)/)
	m.each do |match|
		prices[match[1].to_sym] = match[0].scan(/\d+\d+/).join('-')
	end
end

pp prices

Dir.mkdir(save) unless File.exists?(save)
f = File.new(save+Time.now.to_s,'w')
JSON.dump(prices,f)


p 'done, you lovely person you'


