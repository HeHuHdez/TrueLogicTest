require_relative 'soccer_data'
require_relative 'weather_data'

soccer_file_path = 'fixtures/soccer.dat'
soccer_data = SoccerData.new(soccer_file_path)
team_with_minimum_spread = soccer_data.calculate_team_with_minimun_spread
puts "Soccer: Team with minimum spread: #{team_with_minimum_spread}"

puts "\n"

weather_file_path = 'fixtures/w_data.dat'
weather_data = WeatherData.new(weather_file_path)
day_with_minimum_spread = weather_data.calculate_day_with_minimun_spread
puts "Weather: Day with minimum spread: #{day_with_minimum_spread}"