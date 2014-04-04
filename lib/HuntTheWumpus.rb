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
    case command
    when :move_north, :move_south, :move_west, :move_east
      move_result = attempt_to_move command
      @explored_rooms << [@player_location.row, @player_location.col]
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
      @messages = [:ran_into_a_wall] 
    else
      @messages = [:you_moved]
      @player_location.row += move_direction[0]
      @player_location.col += move_direction[1]

      room = @cave[@player_location.row][@player_location.col]

      case room
      when :gold
        @messages << :you_see_gold
      end
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
    return OpenStruct.new(:map => build_cave_for_ui, :messages => @messages)
  end

  def ongoing?
    true
  end
end