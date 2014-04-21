
# A Tiny Timer

class Timer

	def self.wait(seconds=1)
		a = Time.now
		while(Time.now-a < seconds)
			#wait...
		end
	end

	def self.wait_with_notice(seconds=1,notice_interval=1)
		while seconds>0
			w = seconds
			w = notice_interval if notice_interval < seconds
			wait w
			p "There is "+seconds_to_string(seconds)+" remaining."
			seconds = seconds-notice_interval
		end
	end

	def self.start()
		@@start_time = Time.now
	end

	def self.stop()
		(Time.now-@@start_time)
	end

	def self.seconds_to_string(seconds)
		m = seconds/60
		h = m/60
		s = seconds-(m*60)
		m = m-(h*60)
		h.to_s+":"+m.to_s+":"+s.to_s
	end

end

p Timer.start
#Timer.wait_with_notice(60)
p Timer.stop

