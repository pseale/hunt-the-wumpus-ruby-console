require 'require_all'
require_all 'lib'
require 'pry'

class HuntTheWumpusConsoleUI
  def initialize
    @cave_glyphs = { 
      :unexplored => "?", 
      :player => "@", 
      :entrance => "e", 
      :empty => ".",
      :gold => "$",
      :weapon => "t",
      :wumpus => "W",
      :pitfall => "p"
    }

    @message_text = {
      :you_enter_the_cave => "With much trepidation, you enter the cave. It is musty.",
      :ran_into_a_wall => "You run into a wall!",
      :you_moved => "You move swiftly and gracefully, like a swan.",
      :you_see_gold => "You see gold strewn about the floor.",
      :you_see_a_weapon => "Before you is a shiny steel sword. It looks very sharp.",
      :looted_gold => "You stuff the gold coins into your pockets. The gold makes a satisfying, clinking noise as you walk.",
      :looted_weapon => "You grasp the sword by the hilt and pick it up, examining the sturdy craftsmanship and sharp edge. Yes, this will do.",
      :you_failed_to_loot => "There is nothing to loot.",
      :there_is_a_foul_odor => "The air is thick with a powerful stench. You must be near a wumpus.",
      :there_is_a_howling_wind => "The air gusts about you. Is there an opening in the walls or ceiling nearby? Or perhaps, a large pit in the floor?",
      :you_escape => "You make a strategic withdrawal from the cave.",
      :you_fall => "OH NO! You fall into a pit and perish. RIP.",
      nil => "error"
    }
  end

  def build_cave_walls(size)
    "*" * (size + 2) + "\n"
  end

  def build_cave_row(row)
    row_string = ""

    row.each do |room|
      row_string += @cave_glyphs[room]
    end  

    "*" + row_string + "*\n"
  end

  def build_string_from_map(map)
    string = build_cave_walls map.size
    (0..map.size-1).each do |row|
      string += build_cave_row map[row]
    end
    string += build_cave_walls map.size

  end

  def print_game_status(status)
    puts build_string_from_map status.map
    status.messages.each do |message|
      puts @message_text[message]
    end

    points_text = status.points == 1 ? "point" : "points";
    armed_text = status.armed ? "ARMED|" : ""
    print "[#{armed_text}#{status.points} #{points_text}]"
  end

  def print_help
    puts "-=-=-=-=-=-=-=-=-  Help  -=-=-=-=-=-=-=-=-=-=-"
    puts "? -- help to show this list of moves a player can make
  N -- move north 1 space - cannot move north if the cave ends (outside of grid)
  S -- move south 1 space - cannot move south if the cave ends (outside of grid)
  E -- move east 1 space - cannot move east if the cave ends (outside of grid)
  W -- moves west 1 space - cannot move west if the cave ends (outside of grid)
  L -- loot either gold or weapon in the room
  R -- run out of the cave entrance and head to the local inn to share your tale
  X -- this is a hard exit out of the game. The game ends with no points awarded."  
  end

  def print_final_status(game)
    status = game.final_status
    status.messages.each do |message|
      puts @message_text[message]
    end
    puts "*** GAME OVER ***"
    puts "Final score: #{status.points} points"
  end

  def run
    puts "~~~~~~~ Hunt the Wumpus ~~~~~~"
    puts ""
    print "How large of a cave would you like to explore (between 10 and 20)? >"
    cave_size = gets.to_i
    cave_size = Random.new().rand(10..20) if cave_size < 10 || cave_size > 20
    cave_size = [[cave_size, 10].max, 20].min

    puts ""
    puts "Creating cave #{'.'*cave_size}" 
    puts ""
    game = HuntTheWumpus.new(cave_size)

    run_game_loop game
    print_final_status game
  end

  def run_game_loop(game)
    while (game.ongoing?) do
      print_game_status game.status
      print ">"
      input = gets.chomp

      case input.chomp.upcase
      when "X"
        exit
      when "?"
        print_help
      when "S"
        game.receive_command(:move_south)
      when "N"
        game.receive_command(:move_north)
      when "W"
        game.receive_command(:move_west)
      when "E"
        game.receive_command(:move_east)
      when "L"
        game.receive_command(:loot)
      when "R"
        game.receive_command(:run)
      else
        puts "Invalid command '#{input}'."
        puts ""
        print_help 
      end
    end
  end    
end

HuntTheWumpusConsoleUI.new.run
