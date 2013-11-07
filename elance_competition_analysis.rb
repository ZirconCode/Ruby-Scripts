
# Analyze Your Competition for a Job on elance.com

# by ZirconCode

require 'nokogiri'
require 'open-uri'
require 'pp'

require_relative 'cache.rb'


def clean(string)
	string.delete("\n").delete("\t")
end

def get_person(slug)

	person = Hash.new
	url = 'https://www.elance.com/s/'+slug
	doc = Cache.c(url)

	person[:slug] = slug
	person[:name] = doc.xpath("//*[@id='p-title']/text()").text.strip
	person[:tagline] = doc.xpath("//*[@id='p-hd']/div[1]/span").text

	overview = doc.xpath("//*[@id='p-overview']/div[1]/p").text
	person[:overview] = clean(overview)

	skills = doc.xpath("//*[@id='profileSkills']/tbody/tr/td/div/text()")
	skills = skills.map{|s| clean(s.text)}.reject{|i| !i || i.empty?}
	person[:skills] = skills

	keywords = doc.xpath("//*[@id='p-keywords']/div/div/text()")
	keywords = keywords.map{|s| clean(s.text)}.reject{|i| !i || i.empty?}
	person[:keywords] = keywords

	person
	# gets skills, keyword extraction from overview, hourly, etc... 
end


def get_job(slug)
	#https://www.elance.com/j/ + slug

	# gets proposals->people
end


# get job
# get people
# display statistics of people
# ?compare to you?

pp get_person('simon-g')

