

# could not even find a single line of ruby related to .srt files...
def parseSRT(path)
	result = []
	current = Hash.new
	type = :line
	c = File.read(path)

	c.each_line("\n") do |s| 
		if s.chomp.empty?
			result << current
			current = Hash.new
			type = :line
		else
			case type
			when :line
				current['subtitle_number'] = s.to_i
				type = :time
			when :time
				current['time_start'] = s.chomp.split('-->')[0].strip.gsub(",",".")
				current['time_end'] = s.chomp.split('-->')[1].strip.gsub(",",".")
				type = :text
			when :text
				current['text'] = '' if current['text'].nil?
				current['text'] = current['text']+s
			end
		end
	end

	result
end

# WARNING Franken-Code Ahead
#  *rmovie did not work as ffmpeg wrapper for me
# <3 ffmpeg
# hint: install all the codecs

def grabPicture(input_path,output_path,time)
	 `ffmpeg -ss #{time} -i "#{input_path}" -y -f image2 -vcodec mjpeg -vframes 1 "#{output_path}"` #mjpeg
end

def grabSegment(input_path,output_path,start_time,end_time)
	# !!! TODO: BIG PROBLEM IF LARGE MOVIE WHICH IS ACTUAL USE CASE
	# make missin keyframes for good time accuracy
	#tmp = "data/temp.avi"
	puts start_time
	puts end_time
	#{}`ffmpeg -i "#{input_path}" -force_key_frames #{start_time},#{end_time} "#{tmp}"`
	# ^^^ !!! TODO: BIG PROBLEM IF LARGE MOVIE WHICH IS ACTUAL USE CASE

	# copy exact stuff...
	#cmd = "ffmpeg -ss #{start_time} -vcodec copy -acodec copy -i \"#{input_path}\" -t #{time} -y \"#{output_path}\""
	#puts cmd
	`ffmpeg -vcodec copy -acodec copy -i "#{input_path}" -ss #{start_time} -t #{end_time} -y "#{output_path}"`
end

def grabAMinute(input_path,output_path,start_time)
	grabSegment(input_path,output_path,start_time,"60")
end

def grabSubtitle(input_path,output_path,subtitle)
	# expects hash from #parseSRT
	start_time = subtitle['time_start']
	end_time = subtitle['time_end']
	end_time = "00:00:33.500"
	grabSegment(input_path,output_path,start_time,end_time)
end

class MovTime
	# ! UGLY

	# expected format: "hh:mm:ss.mil"
	def self.toA(string)
		a = string.split(/[:|.]/).collect {|s| s.to_i}
	end

	def self.fromA(a)
		"#{a[0].to_s}:#{a[1].to_s}:#{a[2].to_s}.#{a[3].to_s}"
	end

	def self.add(one,two)
		o = toA(one)
		t = toA(two)
		r = []
		o.count.times {|i| r<<(o[i]+t[i])}
		fromA(r)
	end

	def self.difference(one,two)
		o = toA(one)
		t = toA(two)
		r = []
		o.count.times {|i| r<<((o[i]-t[i])).abs}
		fromA(r)
	end
end


def processMovie(movie,subtitles)
	subs = parseSRT(subtitles)


end


puts "===================== ^_^ ====================="
input = "data/movie.avi"
output = "data/out.avi"
subs = parseSRT("data/subs.srt")
#processMovie("data/movie.avi","data/subs.srt")
#grabPicture("data/movie.avi","data/pic.jpg","00:59:14.435")
#grabAMinute("data/movie.avi","data/out.avi","00:15:14.435")
grabSubtitle(input,output,subs.first)
puts "===================== =) ====================="