module DataMethods
  def initialize(file_path)
    file = File.read(file_path)
    @data = get_data(file)
  end

  private

  def get_data(file)
    raise 'NotImplementedError'
  end

  def get_spread(min, max)
    max.to_f - min.to_f
  end
end
