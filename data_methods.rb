# frozen_string_literal: true

module DataMethods
  def initialize(file_path)
    file = File.read(file_path)
    @data = get_data(file)
  end

  private

  def get_data(file)
    raise 'NotImplementedError'
  end

  def calculate_minimum_spread(min_key, max_key)
    min_spread = nil
    min_spread_item = nil

    @data.each do |item|
      spread = get_spread(item[min_key], item[max_key])

      if min_spread.nil? || spread < min_spread
        min_spread = spread
        min_spread_item = item
      end
    end

    min_spread_item
  end


  def get_spread(min, max)
    (max.to_f - min.to_f).abs
  end
end
