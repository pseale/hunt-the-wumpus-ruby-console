require 'ostruct'

class StatusFormatter
  def self.format(cave, player_location, explored_rooms, messages, points, armed)
    OpenStruct.new(:map => build_cave_for_ui(cave, player_location, explored_rooms), 
      :messages => Array.new(messages), 
      :points => points, 
      :armed => armed
      )
  end

  def self.explored?(explored_rooms, row, col)
    explored_rooms.include?([row, col])
  end

  def self.build_cave_for_ui(cave, player_location, explored_rooms)
    ui_cave = []
    (0..cave.size-1).each do |row|
      ui_row = []
      (0..cave.size-1).each do |col|
        if player_location.row == row && player_location.col == col
          ui_row << :player 
        elsif explored?(explored_rooms, row, col)
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