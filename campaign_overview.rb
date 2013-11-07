
# Social Media Campaign Data Scraper & Analyzer

# by ZirconCode

# TODO gonna have to use headlessly&watir again... sigh~
# they don't like scrapers XD
# TODO DRY the getters via scraping methods, fix xpaths...

# ----
$youtube_link 	 = 'http://www.youtube.com/user/xinamadden2'
$instagram_link  = 'http://instagram.com/xinamadden'
$deviantart_link = 'http://xinamadden.deviantart.com/'
# ----

require_relative 'cache.rb'
require 'pp'

# nokogiri .text scrape
def ns(doc,identifier)
	doc.xpath(identifier).text
end


def get_youtube_stats(url)

	doc = Cache.c(url+'/about')
	stats = Hash.new

	stats[:views] = ns(doc,"//*[@id='c4-about-tab']/div/div[2]/ul/li[1]/span")

	stats

end

def get_instagram_stats(url)

	doc = Cache.c(url)
	stats = Hash.new

	# TODO Failure
	stats[:followers] = ns(doc,"/html/body/span/div/div/div/div/div/ul/li[2]/span/span[2]")

	stats

end

def get_deviant_stats(url)

	doc = Cache.c(url+'/stats/gallery')
	stats = Hash.new

	# TODO Failure
	stats[:views] = ns(doc,"//*[@id='ViewsTotalDiv']")

	stats

end

pp get_youtube_stats($youtube_link)
pp get_instagram_stats($instagram_link)
pp get_deviant_stats($deviantart_link)
