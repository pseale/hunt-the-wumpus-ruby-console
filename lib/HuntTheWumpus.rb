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

    @explored_rooms = []
    @cave = CaveGenerator.generate_a_cave(cave_size)
    place_player_at_entrance
  end

  def place_player_at_entrance
    (0..@cave.size-1).each do |row|
      (0..@cave.size-1).each do |col|
        @player_location = OpenStruct.new(:row => row, :col => col) if @cave[row][col] == :entrance
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
    @explored_rooms << [@player_location.row, @player_location.col]
    @player_location.row += 1
  end

  def status
    return OpenStruct.new(:map => build_cave_for_ui)
  end

  def ongoing?
    true
  end
end