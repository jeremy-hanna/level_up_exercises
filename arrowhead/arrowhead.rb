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
    return unless valid?(region, shape)

    "You have a(n) '#{CLASSIFICATIONS[region][shape]}' arrowhead. Probably priceless."
  end

  def self.valid?(region, shape)
    valid_region?(CLASSIFICATIONS[region]) && 
    valid_shape?(CLASSIFICATIONS[region][shape]) 
  end

  def self.valid_region?(region)
    return true if region
    raise RegionError, "Unknown region, please provide a valid region."
  end

  def self.valid_shape?(shape)
    return true if shape
    raise ShapeError, "Unknown shape value. Are you sure you know what you're talking about?"
  end
end

ShapeError = Class.new(StandardError)

RegionError = Class.new(StandardError)

puts Arrowhead.classify(:northern_plains, :bifurcated)
