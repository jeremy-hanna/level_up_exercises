module DataScience
  class Cohort
    attr_accessor :sample_size, :conversions

    def initialize
      @sample_size = 0
      @conversions = 0
    end

    def increment(result)
      @sample_size += 1
      @conversions += result
    end

    def conversion_rate_avg
      return 0 if @sample_size == 0
      @conversions.fdiv @sample_size
    end
  end
end
