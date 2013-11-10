
# Agile Scraper

# uses simple caching, different methods of access, timeouts/error management, etc...
# will expand to gem perhaps

# / ZirconCode

require 'nokogiri'
require 'open-uri'
require 'watir-webdriver'
require 'headless' # needs xvfb installed
require 'json' # yeah?


class Scraper

	@access_type = :headless # or :openuri, etc..

	def initialize(scrape_type=:headless)
		@access_type = scrape_type
	end
	

	def start()
		# start headless
		if(@access_type == :headless)
			@headless = Headless.new
			headless.start
			@browser = Watir::Browser.new
		end
	end
	
	def stop()
		# end headless/close stuff
		if(@access_type == :headless)
			@browser.close
			@headless.destroy
		end
	end
	
	
	def go(url)
		# visit and cache the url
	end
	
	def get(url)
		# go(url) if not exists in cache
		# return result
	end
	
	
	def scrape_methods()
		# puts some very simple scraping methods here, nokogiri et al~
	end
	
	# add Cache module/management
	

end


s = Scraper.new
puts "test"


