
# Agile Scraper

# uses simple caching, different methods of access, timeouts/error management, etc...
# will expand to gem perhaps

# / ZirconCode

class Scraper

	@web_access = :headless # or :openuri, etc..

	def initialize(scrape_type)
		@web_access = scrape_type if scrape_type
	end
	


	def start()
		# start headless
	end
	
	def stop()
		# end headless/close stuff
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


