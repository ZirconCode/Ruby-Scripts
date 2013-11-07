

module Cache

	Cache = Hash.new

	def self.c(url)
		if !Cache[:site]
			doc = Nokogiri::HTML(open(url))
			Cache[:site] = doc
		end

		Cache[:site]
	end

	def self.save_cache
		# json stuff
	end

	def self.load_cache
		# json stuff
	end

end

