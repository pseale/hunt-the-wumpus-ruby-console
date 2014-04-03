require 'require_all'
require_all 'lib'

def print_game_status(status)
  puts "GAMESTATUSGOESHERE"
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

puts "~~~~~~~ Hunt the Wumpus ~~~~~~"
puts ""
print "How large of a cave would you like to explore? >"
cave_size = gets.to_i
cave_size = Random.new().rand(10..100) if cave_size < 10 || cave_size > 100
cave_size = [[cave_size, 10].max, 100].min

puts ""
puts "Creating cave #{'.'*cave_size}" 
game = HuntTheWumpus.new(cave_size)


while (game.ongoing?) do
  print_game_status game.status
  print ">"
  input = gets.chomp

  case input
  when /x|X/
    exit
  when "?"
    print_help
  else
    puts "Invalid command '#{input}'."
    puts ""
    print_help 
  end
end
