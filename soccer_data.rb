# frozen_string_literal: true

require_relative 'data_methods'
require 'scanf'

class SoccerData
  attr_accessor :data

  include DataMethods

  FORMAT = "%21c %d %d %d %d %d - %d %d"
  GOALS_FOR_KEY = 'F'
  GOALS_AGAINST_KEY = 'A'
  TEAM_KEY = 'Team'

  def calculate_team_with_minimun_spread
    calculate_minimum_spread(GOALS_FOR_KEY, GOALS_AGAINST_KEY)[TEAM_KEY].strip
  end

  private

  def get_data(file)
    table_lines = file.split("\n").select { |line| line.length >= 58 && !line.include?('---') }
    columns = table_lines.first.strip.split
    table_lines[1..-1].map do |line|
      columns.zip(line.scanf(FORMAT)).to_h
    end
  end
end
