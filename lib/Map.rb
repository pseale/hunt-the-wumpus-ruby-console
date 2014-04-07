class Map
  def initialize(cave)
    @cave = cave
    @explored_rooms = []

    place_player_at_entrance
  end

  def place_player_at_entrance
    entrance = @cave.get_entrance_location

    @player_location = entrance
    @explored_rooms << entrance
  end

  def move_player(direction)
    @player_location = @player_location.move(direction)
  end

  def move_is_out_of_bounds?(direction)
    row = @player_location.row + direction.row
    col = @player_location.col + direction.col

    return true if (row < 0 || row >= @cave.size)
    return true if (col < 0 || col >= @cave.size)
    return false
  end

  def current_room
    @cave[@player_location.row, @player_location.col]
  end

  def current_location
    @player_location
  end

  def current_room_is_unexplored?
    @explored_rooms.none? {|room| room.row == @player_location.row && room.col == @player_location.col }
  end

  def explored?(row, col)
    @explored_rooms.any? { |room| room.row == row && room.col == col }
  end

  def mark_room_as_explored
    @explored_rooms << current_location
  end
end