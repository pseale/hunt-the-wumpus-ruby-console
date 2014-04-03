require 'ostruct'
require 'pry'

class CaveTooSmallError < StandardError; end
class CaveTooLargeError < StandardError; end

class HuntTheWumpus
  def initialize(cave_size)
    raise CaveTooSmallError if cave_size < 10
    raise CaveTooLargeError if cave_size > 20

    @explored_rooms = []
    create_cave cave_size
    place_player_at_entrance
  end

  def create_cave_rooms(room_type, number_of_rooms)
    rooms = []
    number_of_rooms.times do 
      rooms << room_type
    end

    rooms
  end

  def create_cave(size)
    total_rooms = size * size
    total_rooms_created_with_fifteen_percent_chance = total_rooms * 15 / 100
    rooms = []
    rooms.concat(create_cave_rooms :entrance, 1)
    rooms.concat(create_cave_rooms :weapon, total_rooms_created_with_fifteen_percent_chance)
    rooms.concat(create_cave_rooms :gold, total_rooms_created_with_fifteen_percent_chance)
    rooms.concat(create_cave_rooms :wumpus, total_rooms_created_with_fifteen_percent_chance)

    rooms_remaining_empty = total_rooms - rooms.size

    rooms.concat(create_cave_rooms :empty, rooms_remaining_empty)

    rooms.shuffle!

    @cave = []
    
    size.times do
      cave_row = []
      size.times do
        cave_row << rooms.pop
      end
      @cave << cave_row
    end
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

  def status
    return OpenStruct.new(:map => build_cave_for_ui)
  end

  def ongoing?
    true
  end
end