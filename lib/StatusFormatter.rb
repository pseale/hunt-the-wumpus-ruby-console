require 'ostruct'

class StatusFormatter
  def self.format_status(cave, map, messages, scoreboard, armed)
    OpenStruct.new(
      :map => build_cave_for_ui(cave, map),
      :messages => Array.new(messages),
      :points => scoreboard.points,
      :armed => armed
      )
  end

  def self.format_final_status(messages, scoreboard)
    OpenStruct.new(
      :messages => Array.new(messages), 
      :points => scoreboard.points
      )
  end

  def self.build_cave_for_ui(cave, map)
    ui_cave = []
    (0..cave.size-1).each do |row|
      ui_row = []
      (0..cave.size-1).each do |col|
        if map.current_location.row == row && map.current_location.col == col
          ui_row << :player 
        elsif map.explored?(row, col)
          ui_row << cave[row, col]
        else
          ui_row << :unexplored
        end
      end
      ui_cave << ui_row
    end
    ui_cave
  end
end