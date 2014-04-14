


require 'json'
def loadHistory(filename)
	# Json export of chrome history through github.com/christiangenco/chrome-export-history
	JSON.parse(IO.read(filename))
end


def topDomains(history) # total visits
	# Get Top Websites
	domains = Hash.new
	history.each do |b|
		d = b['url'].scan(/\/\/(.*?)\//).to_a.first #meh...
		domains[d] = 0 if domains[d] == nil
		domains[d] = domains[d] + b['visitCount']
	end
	domains = domains.sort_by { |k,v| v }
end

def siteUse(names, history) # across time...
	days = Hash.new
	history.each do |b|
		t = Time.at(b['lastVisitTime']/1000)
		d = b['url'].scan(/\/\/(.*?)\//).to_a.flatten.first #meh...
		key = t.month.to_s+','+t.day.to_s
		if(d!= nil)
			matches = false
			names.each {|n| matches = true if d.include?(n)}
			if(matches == true)
				days[key] = 0 if days[key] == nil
				days[key] = days[key] + b['visitCount']
			end
		end
	end
	days
end



# Example Use
h = loadHistory('history.json')
puts 'Items Loaded: '+h.count.to_s

puts topDomains(h)
puts siteUse(['reddit','imgur'],h)

#File.open("output.txt","w") do |f|
#	blah.each{|l| f<<l<<"\n"}
#end

