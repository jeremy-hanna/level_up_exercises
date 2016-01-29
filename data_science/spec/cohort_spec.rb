require_relative 'spec_helper'
require_relative '../lib/cohort'

describe DataScience::Cohort do 
  let!(:cohort) do
    DataScience::Cohort.new
  end

  describe '#increment' do
    context 'when a cohort is created' do

      it { expect(cohort.sample_size).to eq(0) }
      it { expect(cohort.conversions).to eq(0) }

    end

    context 'when cohort is incremented' do

      it 'a passing result' do
        cohort.increment(1)

        expect(cohort.sample_size).to eq(1) 
        expect(cohort.conversions).to eq(1) 
      end

      it 'a failed result' do
        cohort.increment(0)

        expect(cohort.sample_size).to eq(1) 
        expect(cohort.conversions).to eq(0) 
      end

      it 'multiple varying results' do
        results = [0, 1, 0, 1]
        results.each { |result| cohort.increment(result) }

        expect(cohort.sample_size).to eq(4)
        expect(cohort.conversions).to eq(2) 
      end

    end
  end

  describe '#conversion_rate_avg' do
    context 'when a conversion rate is calculated' do

      it { expect(cohort.conversion_rate_avg).to eq(0.00) } 

      it 'on an real result' do
        results = [0, 1, 0, 1]
        results.each { |result| cohort.increment(result) }

        expect(cohort.conversion_rate_avg).to eq(0.50) 
      end

    end
  end 
end
