# frozen_string_literal: true

require 'rspec'
require_relative '../data_methods'  #

describe DataMethods do
  let(:dummy_file_path) { File.expand_path('../../fixtures/w_data.dat', __FILE__) }

  subject { DataMethodsTester.new(dummy_file_path) }

  describe '#initialize' do
    it 'reads data from the file and initializes @data' do
      expect(subject.instance_variable_get(:@data)).to be_a(Array)
      expect(subject.instance_variable_get(:@data).length).to be > 0
    end
  end

  describe '#get_spread' do
    it 'calculates the spread between min and max temperatures' do
      expect(subject.send(:get_spread, '59', '88')).to eq(29.0)
      expect(subject.send(:get_spread, '73', '57')).to eq(16.0)
    end
  end

  describe '#get_data' do
    subject { DataMethodsNotImplementedTester.new(dummy_file_path) }

    context 'when the method is not implemented in the including class' do

      it 'raises NotImplementedError' do
        expect { subject.send(:get_data, 'dummy_file_content') }.to raise_error('NotImplementedError')
      end
    end
  end
end


class DataMethodsTester
  include DataMethods

  def get_data(file)
    # Dummy implementation
    [1,2]
  end
end

class DataMethodsNotImplementedTester
  include DataMethods
end