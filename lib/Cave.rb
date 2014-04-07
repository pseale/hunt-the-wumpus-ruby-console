class Cave
  attr_reader :size

  def initialize(rooms, size)
    @size = size
    @cave_rows = []
    size.times do
      cave_row = []
      size.times do
        cave_row << rooms.pop
      end
      @cave_rows << cave_row
    end

  end

  def [](row, col)
    @cave_rows[row][col]
  end

  def clear_room(location)
    @cave_rows[location.row][location.col] = :empty
  end

  def change_weapon_rooms_to_gold
    (0..@size-1).each do |row|
      (0..@size-1).each do |col|
        @cave_rows[row][col] = :gold if @cave_rows[row][col] == :weapon
      end
    end
  end
end

