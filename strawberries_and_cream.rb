

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

$neuron_potential_loss = 0.1

$signal_strength_loss = 0.1

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
		Location.distance(self,loc2)
	end

	def self.distance(loc1,loc2)
		sum = 0
		$dimensions.times{|i| sum = sum+((loc2.coordinates[i]-loc1.coordinates[i])**2)}
		Math.sqrt(sum)
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

	def tick()
		@potential = @potential-$neuron_potential_loss if @potential>0
		@potential = 0 if @potential<0

		# TODO, fire, influence, signals
	end

	attr_reader :location, :axon_location, :potential
end

# signals
class Chem

	def initialize(args={})
		@location = args[:location] || Location.new(nil)
		@strength = args[:strength] || $rand.rand(100)
		@size = args[:size] || $rand.rand($dimensions_size/10)
		@type = args[:type] || 1
	end

	def tick()
		@strength = @strength-$signal_strength_loss
		@strength = 0 if @strength<0


	end

end

class Network

	def initialize(size)
		# TODO make neurons and signals inherit from entity
		@neurons = []
		@signals = []
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

