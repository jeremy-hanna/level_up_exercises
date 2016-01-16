class Arrowhead
  # This seriously belongs in a database. Agreed.
  CLASSIFICATIONS = {
    far_west: {
      notched: "Archaic Side Notch",
      stemmed: "Archaic Stemmed",
      lanceolate: "Agate Basin",
      bifurcated: "Cody",
    },
    northern_plains: {
      notched: "Besant",
      stemmed: "Archaic Stemmed",
      lanceolate: "Humboldt Constricted Base",
      bifurcated: "Oxbow",
    },
  }

  def self.classify(region, shape)
    if validate?(region, shape)
      "You have a(n) '#{CLASSIFICATIONS[region][shape]}' arrowhead. Probably priceless."
    end
  end

  def self.validate?(region, shape)
    return valid_region?(CLASSIFICATIONS[region]) &&
           valid_shape?(CLASSIFICATIONS[region][shape]) 
  end

  def self.valid_region?(region)
    region.nil? ? (raise RegionError.new) : true
  end

  def self.valid_shape?(shape)
    shape.nil? ? (raise ShapeError.new) : true
  end
end

class ShapeError < StandardError
  def initialize(msg = "Unknown shape value. Are you sure you know what you're talking about?")
    super
  end
end

class RegionError < StandardError
  def initialize(msg = "Unknown region, please provide a valid region.")
    super
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
