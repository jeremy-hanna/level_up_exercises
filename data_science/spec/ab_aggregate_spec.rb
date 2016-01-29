require_relative 'spec_helper'
require_relative '../lib/ab_aggregate'

describe DataScience::ABAggregate do
  describe '#entire_sample_size' do
    let!(:empty_aggregate) do
      DataScience::ABAggregate.new
    end

    let!(:sample_result_A) do
      { date: '2014-03-20', cohort: 'A', result: 1 }
    end

    let!(:sample_result_B) do
      { date: '2014-03-20', cohort: 'B', result: 1 }
    end

    context 'when aggregate is' do

      it 'empty' do
        expect(empty_aggregate.entire_sample_size).to eq(0) 
      end

      it 'a single result on a cohort' do
        empty_aggregate.add_result sample_result_A

        expect(empty_aggregate.entire_sample_size).to eq(1) 
      end

      it 'multiple results on different cohorts' do 
        empty_aggregate.add_result sample_result_A
        empty_aggregate.add_result sample_result_B

        expect(empty_aggregate.entire_sample_size).to eq(2) 
      end

    end 
  end

  describe "#add_result" do
    let!(:empty_aggregate) do
      DataScience::ABAggregate.new
    end

    let!(:sample_result_A) do
      { date: '2014-03-20', cohort: 'A', result: 1 }
    end

    let!(:sample_result_B) do
      { date: '2014-03-20', cohort: 'B', result: 1 }
    end

    context "when adding a result" do

      it 'to an empty aggregate' do
        empty_aggregate.add_result(sample_result_A)
 
        expect(empty_aggregate.entire_sample_size).to eq(1)
      end

      it 'to different cohorts' do
        empty_aggregate.add_result(sample_result_A)
        empty_aggregate.add_result(sample_result_B)

        expect(empty_aggregate.cohort_sample_size(sample_result_A[:cohort])).to eq(1)
        expect(empty_aggregate.cohort_sample_size(sample_result_B[:cohort])).to eq(1)
        expect(empty_aggregate.entire_sample_size).to eq(2)
      end

    end
  end

  describe '#cohort_conversion_range' do
    let!(:empty_aggregate) do
      DataScience::ABAggregate.new
    end

    context 'when empty' do

      it { expect(empty_aggregate.cohort_conversion_range("A")). to eq([0, 0]) }
      it { expect(false).to be(true), "this probably should return a Conversion Range object. Need to refactor but I am moving on to a new part of the class because of time" }

    end
  end
end
