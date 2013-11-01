

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

$rand = Random.new(240312) # =)

class Location

	def initialize(array)
		@coordinates = array

		randomize if @coordinates == nil
	end

	def randomize
		@coordinates = []
		# should later use $world.upper_location
		$dimensions.times{@coordinates << $rand.rand($dimensions_size)}
	end

	def distance(loc2)

	end

	attr_reader :coordinates
end

class World

	def initialize()
		@lower_location = Location.new([0]*$dimensions)
		@upper_location = Location.new([$dimensions_size]*$dimensions)
	end

	attr_accessor :lower_location, :upper_location
end
$world = World.new

class Neuron

	def initialize()
		@location = Location.new nil
		@axon_location = Location.new nil #within range pls?...
		# dendrites...? or just radius+location?

		@potential = 0
	end

	attr_reader :location, :axon_location, :potential
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

