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

    @cave = CaveGenerator.generate_a_cave(cave_size)
    @map = Map.new(@cave)
    @points = 0
    @armed = false
    @messages = [:you_enter_the_cave]
  end


  def receive_command(command)
    @messages = []

    case command
    when :move_north, :move_south, :move_west, :move_east
      attempt_to_move command
    when :loot
      loot_result = attempt_to_loot
      if loot_result == :looted_gold || loot_result == :looted_weapon
        @points += 5
      end

      @messages << loot_result
    end
  end

  def attempt_to_loot
    if @map.current_room == :gold
      @cave.clear_room(@map.current_location)
      return :looted_gold
    elsif @map.current_room == :weapon
      @cave.clear_room(@map.current_location)
      @armed = true
      @cave.change_weapon_rooms_to_gold
      return :looted_weapon
    else
      return :you_failed_to_loot
    end
  end

  def attempt_to_move(move_command)
    case move_command
    when :move_north
      direction = Location.new(-1, 0)
    when :move_south
      direction = Location.new(1, 0)
    when :move_west
      direction = Location.new(0, -1)
    when :move_east
      direction = Location.new(0, 1)
    end

    move_result = @map.attempt_to_move(direction)

    if move_result.ran_into_a_wall
      @messages << :ran_into_a_wall
    else
      @messages << :you_moved
      case @map.current_room
      when :gold
        @messages << :you_see_gold
      when :weapon
        @messages << :you_see_a_weapon
      end

      if move_result.room_is_newly_explored && @map.current_room == :empty
        @points += 1;
      end
    end
  end

  def status
    StatusFormatter.format(@cave, @map, @messages, @points, @armed)
  end

  def ongoing?
    true
  end
end