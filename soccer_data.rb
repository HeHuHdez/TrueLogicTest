# frozen_string_literal: true

require_relative 'data_methods'
require 'scanf'

class SoccerData
  attr_accessor :data

  include DataMethods

  def calculate_team_with_minimun_spread
    calculate_minimum_spread('F', 'A')['Team'].strip
  end

  private

  def get_data(file)
    table_lines = file.split("\n").select { |line| line.length >= 58 && !line.include?('---') }
    columns = table_lines.first.strip.split
    table_lines[1..-1].map do |line|
      columns.zip(line.scanf("%21c %d %d %d %d %d - %d %d")).to_h
    end
  end
end
