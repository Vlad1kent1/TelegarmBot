class Field
  def initialize(id)
    @id = id
    @data = Hash[(1..9).map { |i| [i, 0] }]
  end

  def values
    @data
  end

  def read_id
    @id
  end

  def [](key)
    @data[key]
  end

  def []=(key, value)
    @data[key] = value
  end

  def each(&block)
    @data.each(&block)
  end

  def clear
    @data.each { |key, _| @data[key] = 0 }
  end

  def all_zeros?
    @data.values.all?  { |value| value == 0 }
  end

  def all_positions_filled?
    @data.values.all? { |value| value != 0 }
  end
end
