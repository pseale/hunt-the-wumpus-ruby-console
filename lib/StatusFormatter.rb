require 'ostruct'

class StatusFormatter
  def self.format(cave, map, messages, points, armed)
    OpenStruct.new(:map => build_cave_for_ui(cave, map), 
      :messages => Array.new(messages), 
      :points => points, 
      :armed => armed
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