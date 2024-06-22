class WeatherData
  attr_accessor :data

  def initialize(file_path)
    file = File.read(file_path)
    @data = get_data(file)
  end

  def calculate_day_with_minimun_spread
    min_spread = nil
    min_spread_day = nil
    @data.each do |day|
      spread = get_spread(day['MnT'], day['MxT'])
      if min_spread.nil? || spread < min_spread
        min_spread = spread
        min_spread_day = day['Dy']
      end
    end
    min_spread_day
  end

  private

  def get_data(file)
    table_lines = file.split("\n").select { |line| line.length == 89 }
    columns = table_lines.first.strip.split
    table_lines[1..-1].map do |line|
      columns.zip(line.strip.split).to_h
    end
  end

  def get_spread(min, max)
    max.to_f - min.to_f
  end
end
