require 'ostruct'

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

    out_of_bounds? row, col
  end

  def out_of_bounds?(row, col)
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
    @explored_rooms.none? {|room| room == @player_location }
  end

  def explored?(row, col)
    @explored_rooms.include? Location.new(row, col)
  end

  def mark_room_as_explored
    @explored_rooms << current_location
  end

  def attempt_to_move(direction)
    if move_is_out_of_bounds?(direction)
      return OpenStruct.new(:ran_into_a_wall => true, :room_is_newly_explored => false)
    else
      move_player(direction)
    end

    room_is_newly_explored = false

    if current_room_is_unexplored?
      mark_room_as_explored
      room_is_newly_explored = true
    end

    return OpenStruct.new(:ran_into_a_wall => false, :room_is_newly_explored => room_is_newly_explored)
  end

  def wumpus_nearby?
    nearby_rooms.include? :wumpus
  end

  def nearby_rooms
    nearby_locations = [
      current_location.move(Location.new(-1, 0)),
      current_location.move(Location.new(1, 0)),
      current_location.move(Location.new(0, -1)),
      current_location.move(Location.new(0, 1))
      ].select { |loc| !out_of_bounds? loc.row, loc.col }

    nearby_locations.map { |location| @cave[location.row, location.col] }
  end
end