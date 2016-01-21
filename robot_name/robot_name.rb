class Robot
  attr_accessor :name

  @@registry ||= [] 

  def initialize(args = {})
    robot_namer = args[:name_generator] || self.method(:name_generator)

    @name = robot_namer.call

    add_to_registry
  end

  def name_generator
    "#{call_multiple_times(2, self.method(:generate_letter))}" \
      "#{call_multiple_times(3, self.method(:generate_digit))}"
  end

  def add_to_registry
    if name_collision? @name
      raise NameCollisionError, "There was a problem generating the robot name, #{@name}!"
    end

    @@registry << @name
  end

  def call_multiple_times(number, _lambda)
    string = ''

    number.times do |i|
      string += "#{_lambda.call}"
    end

    string
  end

  def generate_letter 
    ('A'..'Z').to_a.sample 
  end

  def generate_digit 
    rand(10)
  end 
  
  def name_collision?(name)
    !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) ||
      @@registry.include?(name)
  end
end

NameCollisionError = Class.new(RuntimeError)

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
