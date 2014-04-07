require 'require_all'
require_all 'lib'

require 'ostruct'
require 'pry'

class CaveTooSmallError < StandardError; end
class CaveTooLargeError < StandardError; end

class HuntTheWumpus
  def initialize(cave_size)
    raise CaveTooSmallError if cave_size < 10
    raise CaveTooLargeError if cave_size > 20

    @cave_size = cave_size
    @explored_rooms = []
    @cave = CaveGenerator.generate_a_cave(cave_size)
    @points = 0
    @armed = false
    place_player_at_entrance
    @messages = [:you_enter_the_cave]
  end

  def place_player_at_entrance
    (0..@cave.size-1).each do |row|
      (0..@cave.size-1).each do |col|
        if @cave[row][col] == :entrance
          @player_location = OpenStruct.new(:row => row, :col => col) 
          @explored_rooms << [row, col]
        end
      end
    end
  end

  def explored?(row, col)
    @explored_rooms.include?([row, col])
  end

  def build_cave_for_ui
    ui_cave = []
    (0..@cave.size-1).each do |row|
      ui_row = []
      (0..@cave.size-1).each do |col|
        if @player_location.row == row && @player_location.col == col
          ui_row << :player 
        elsif explored?(row, col)
          ui_row << @cave[row][col]
        else
          ui_row << :unexplored
        end
      end
      ui_cave << ui_row
    end
    ui_cave
  end

  def receive_command(command)
    @messages = []

    case command
    when :move_north, :move_south, :move_west, :move_east
      move_result = attempt_to_move command
      if move_result == :you_moved
        if @explored_rooms.none? {|room| room[0] == @player_location.row && room[1] == @player_location.col }
          @explored_rooms << [@player_location.row, @player_location.col]
          @points += 1;
        end
      end

      @messages << move_result

    when :loot
      loot_result = attempt_to_loot
      if loot_result == :looted_gold || loot_result == :looted_weapon
        @points += 5
      end

      @messages << loot_result
    end
  end

  def clear_room
    @cave[@player_location.row][@player_location.col] = :empty
  end

  def attempt_to_loot
    room = @cave[@player_location.row][@player_location.col]
    if room == :gold
      clear_room
      return :looted_gold
    elsif room == :weapon
      clear_room
      @armed = true
      change_weapon_rooms_to_gold
      return :looted_weapon
    else
      return :you_failed_to_loot
    end
  end

  def change_weapon_rooms_to_gold
    (0..@cave_size-1).each do |row|
      (0..@cave_size-1).each do |col|
        @cave[row][col] = :gold if @cave[row][col] == :weapon
      end
    end
  end

  def attempt_to_move(move_command)
    case move_command
    when :move_north
      move_direction = [-1, 0]
    when :move_south
      move_direction = [1, 0]
    when :move_west
      move_direction = [0, -1]
    when :move_east
      move_direction = [0, 1]
    end

    if move_is_out_of_bounds?(move_direction)
      return :ran_into_a_wall
    else
      @player_location.row += move_direction[0]
      @player_location.col += move_direction[1]

      room = @cave[@player_location.row][@player_location.col]

      case room
      when :gold
        @messages << :you_see_gold
      when :weapon
        @messages << :you_see_a_weapon
      end

      return :you_moved
    end
  end

  def move_is_out_of_bounds?(move_direction)
    row = @player_location.row + move_direction[0]
    col = @player_location.col + move_direction[1]

    return true if (row < 0 || row >= @cave_size)
    return true if (col < 0 || col >= @cave_size)
    return false
  end

  def status
    return OpenStruct.new(:map => build_cave_for_ui, :messages => @messages, :points => @points, :armed => @armed)
  end

  def ongoing?
    true
  end
end