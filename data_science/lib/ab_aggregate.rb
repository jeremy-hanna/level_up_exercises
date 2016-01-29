require_relative 'cohort'

module DataScience
  class ABAggregate
    attr_accessor :cohorts

    def initialize
      @cohorts = { "A" => Cohort.new, "B" => Cohort.new }
    end

    def add_result(data_hash)
      @cohorts[data_hash[:cohort]].increment data_hash[:result]
    end

    def cohort_conversions(cohort)
      @cohorts[cohort].conversions
    end

    def cohort_sample_size(cohort)
      @cohorts[cohort].sample_size
    end

    def entire_sample_size
      total = 0

      @cohorts.each { |_key, value| total += value.sample_size }
      return total
    end

    def cohort_conversion_range(cohort)
      [0, 0]
    end
  end
end
