require 'require_all'
require_all 'lib'

require 'ostruct'

class CaveTooSmallError < StandardError; end
class CaveTooLargeError < StandardError; end
class InvalidCommandError < StandardError; end

class HuntTheWumpus
  def initialize(cave_size)
    raise CaveTooSmallError if cave_size < 10
    raise CaveTooLargeError if cave_size > 20

    @cave = CaveGenerator.generate_a_cave(cave_size)
    @map = Map.new(@cave)
    @scoreboard = Scoreboard.new
    @armed = false
    @game_over = false
    @messages = [:you_enter_the_cave]
    apply_messages_for_location
  end

  def status
    StatusFormatter.format_status(@cave, @map, @messages, @scoreboard, @armed)
  end

  def final_status
    StatusFormatter.format_final_status(@messages, @scoreboard)
  end

  def ongoing?
    !@game_over
  end

  def receive_command(command)
    @messages = []

    case command
    when :run
      @game_over = true
      @messages << :you_escape
      return
    when :move_north, :move_south, :move_west, :move_east
      attempt_to_move command
    when :loot
      attempt_to_loot
    else
      raise InvalidCommandError
    end

    apply_messages_for_location
  end

  private
  
  def apply_messages_for_location
    return if @game_over
    @messages << :there_is_a_foul_odor if @map.wumpus_nearby?
    @messages << :there_is_a_howling_wind if @map.pitfall_nearby?
  end

  def loot_gold
    @cave.clear_room(@map.current_location)
    @scoreboard.we_looted
    @messages << :looted_gold
  end

  def loot_weapon
    @cave.clear_room(@map.current_location)
    @scoreboard.we_looted
    @armed = true
    @cave.change_weapon_rooms_to_gold
    @messages << :looted_weapon
  end

  def attempt_to_loot
    if @map.current_room == :gold
      loot_gold
    elsif @map.current_room == :weapon
      loot_weapon
    else
      @messages << :you_failed_to_loot
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
      when :empty
        @scoreboard.we_explored_an_empty_room if move_result.room_is_newly_explored 
      when :gold
        @messages << :you_see_gold
      when :weapon
        @messages << :you_see_a_weapon
      when :pitfall
        @messages << :you_fall
        @game_over = true
      when :wumpus
        if @armed
          @messages << :you_slew_a_wumpus
          @scoreboard.we_slew_a_wumpus
          @cave.clear_room(@map.current_location)
        else
          @messages << :you_are_eaten
          @game_over = true
        end
      end
    end
  end
end