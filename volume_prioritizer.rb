
# Proof of Concept automatic volume controller
# Created for Ubuntu PulseAudio server via pactl

# use case ex.: background music which dials down/mutes while watching short clip/podcast

# in code refers; sink -> input_sink

# / ZirconCode


@status = ''

def sinks_changed?
	new_status = `pactl list short sink-inputs` # pactl subscribe ?
	changed = !new_status.eql?(@status)
	@status = new_status

	changed		
end

def get_sinks
	s_by_number = `pactl list short sink-inputs`.scan(/^(\d*)/).flatten
	s_by_binary = `pactl list sink-inputs`.scan(/application.process.binary = "(.*)"/).flatten
	return Hash[s_by_binary.zip(s_by_number)]
end

def fade_volume(sink_number,perc_volume)
	#
end

def change_volume(sink_number,perc_volume)
	puts `pactl set-sink-input-volume #{sink_number} #{perc_volume.to_s}%`
end

def prioritize # TODO custom priority order etc...
	sinks = get_sinks
	puts sinks #
	puts sinks['totem'] #
	return if(sinks['totem']==nil)
	if(sinks.count > 1)
		change_volume(sinks['totem'],11)
	else 
		change_volume(sinks['totem'],55)
	end
end

def dial_down(sink, volume)
	
end

sinks_changed?
while(true)
	prioritize if sinks_changed?
end

