

# Location Based Multi-Dimensional Neural Network*

# *or me trying an awesome idea I just had =)
# By ZirconCode

# ----
# WARNING: UNFINISHED
# TODO: wire input,output,make it tick,work
# ----


require 'pp'


$dimensions = 2
$dimensions_size = 100

$rand = Random.new(240312) # <3

class Location

	def initialize()
		@coordinates = []
		$dimensions.times {@coordinates << 1}
	end

	def distance(loc2)

	end

	attr_reader :coordinates
end

class World

	def initialize()
		@lower_location = [0]*$dimensions
		@upper_location = [$dimensions_size]*$dimensions
	end

	attr_accessor :lower_location, :upper_location
end
$world = World.new

class Neuron

	def initialize()
		@location = []
		# should later use $world.upper_location
		$dimensions.times{@location << $rand.rand($dimensions_size)}
		@potential = 0
	end

	attr_reader :location, :potential
end

class Network

	def initialize(size)
		@neurons = []
		size.times{@neurons << Neuron.new}
	end

	def tick
		# perform a time step
	end

end


# --------

puts 'Hello There =)'

network = Network.new(5)
pp network

puts 'Done'
