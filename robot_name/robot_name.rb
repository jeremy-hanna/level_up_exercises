class Robot
  attr_accessor :name

  @@registry ||= [] 

  def initialize(args = {})
    naming_method = args[:name_generator] || self.method(:generate_name)

    @name = naming_method.call
    add_to_registry
  end

  def generate_name
    @name = "#{call_multiple(2, self.method(:generate_char))}" \
            "#{call_multiple(3, self.method(:generate_num))}"
  end

  def add_to_registry
    if name_collision? @name
      raise NameCollisionError, "There was a problem generating the robot name, #{@name}!"
    end

    @@registry << @name
  end

  def call_multiple(number, lam)
    string = ''
    number.times do |i|
      string += lam.call
    end

    string
  end

  def generate_char 
    ('A'..'Z').to_a.sample 
  end

  def generate_num 
    rand(10).to_s
  end 
  
  def name_collision?(name)
    !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @@registry.include?(name)
  end
end

NameCollisionError = Class.new(RuntimeError)

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
