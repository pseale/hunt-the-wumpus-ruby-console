require 'require_all'
require_all 'lib'

SIZE = 10

class Context
  def self.create_game_with_empty_cave
    create_game_with_cave ""
  end

  def self.create_game_with_cave(partial_cave_map)
    full_map = create_full_map_from partial_cave_map
    CaveGenerator.always_generate_this_hardcoded_cave full_map
    game = HuntTheWumpus.new(SIZE)

    CaveGenerator.reset_behavior_to_normal

    return game
  end

  def self.create_full_map_from(partial_cave_map)
    original_rows = partial_cave_map.split("\n").map { |x| x.strip }
    rows = []

    original_rows.each do |row|
      next if row == ""
      rooms = ""
      row.split("").select { |x| CaveGenerator.template_map.keys.include? x }.each do |room|
        rooms += room
      end

      rooms += "." until rooms.size >= SIZE
      rows << rooms
    end

    rows << ".........." until rows.size >= SIZE

    map = rows.join("\n")
    map.sub!(".", "e") if !map.include? "e"

    return map
  end
end