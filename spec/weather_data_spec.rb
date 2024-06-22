# frozen_string_literal: true

require 'rspec'
require_relative '../weather_data'

describe WeatherData do
  let(:file_path) { File.expand_path('../../fixtures/w_data.dat', __FILE__) }

  subject { WeatherData.new(file_path) }

  describe '#calculate_day_with_minimun_spread' do
    it 'calculates the day with the minimum temperature spread' do
      expect(subject.calculate_day_with_minimun_spread).to eq('14')
    end
  end
end