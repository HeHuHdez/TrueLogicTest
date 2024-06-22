# frozen_string_literal: true

require_relative 'data_methods'

class WeatherData
  attr_accessor :data

  include DataMethods

  MINIMUM_TEMPERATURE_KEY = 'MnT'
  MAXIMUM_TEMPERATURE_KEY = 'MxT'
  DAY_KEY = 'Dy'

  def calculate_day_with_minimun_spread
    calculate_minimum_spread(MINIMUM_TEMPERATURE_KEY, MAXIMUM_TEMPERATURE_KEY)[DAY_KEY]
  end

  private

  def get_data(file)
    table_lines = file.split("\n").select { |line| line.length == 89 }
    columns = table_lines.first.strip.split
    table_lines[1..-1].map do |line|
      columns.zip(line.strip.split).to_h
    end
  end
end
