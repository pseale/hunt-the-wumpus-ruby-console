class Location
  attr_reader :row, :col
  def initialize(row, col)
    @row = row
    @col = col
  end

  def move(direction)
    Location.new(@row + direction.row, @col + direction.col)
  end

  def ==(other)
    @row == other.row && @col == other.col
  end
end