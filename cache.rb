

require 'nokogiri' #sigh~
require 'open-uri'

module Cache

	# TODO, loading saving refresh times and stuff

	Cache = Hash.new

	def self.c(url)
		if !Cache.key? url.to_sym
			Cache[url.to_sym] = Nokogiri::HTML(open(url))
		end

		Cache[url.to_sym]
	end

	def self.save_cache
		# json stuff
	end

	def self.load_cache
		# json stuff
	end

end

