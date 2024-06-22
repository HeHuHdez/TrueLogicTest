class WeatherData
  attr_accessor :data

  def initialize(file_path)
    file = File.read(file_path)
    @data = get_data(file)
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
