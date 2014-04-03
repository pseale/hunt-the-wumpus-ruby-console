class CaveGenerator
  def self.generate_a_cave(size)
    total_rooms = size * size
    total_rooms_created_with_fifteen_percent_chance = total_rooms * 15 / 100
    total_rooms_created_with_five_percent_chance = total_rooms * 5 / 100
    rooms = []
    rooms.concat(create_cave_rooms :entrance, 1)
    rooms.concat(create_cave_rooms :weapon, total_rooms_created_with_fifteen_percent_chance)
    rooms.concat(create_cave_rooms :gold, total_rooms_created_with_fifteen_percent_chance)
    rooms.concat(create_cave_rooms :wumpus, total_rooms_created_with_fifteen_percent_chance)
    rooms.concat(create_cave_rooms :pitfall, total_rooms_created_with_five_percent_chance)

    rooms_remaining_empty = total_rooms - rooms.size

    rooms.concat(create_cave_rooms :empty, rooms_remaining_empty)

    rooms.shuffle!

    cave = []
    
    size.times do
      cave_row = []
      size.times do
        cave_row << rooms.pop
      end
      cave << cave_row
    end

    cave
  end

  def self.create_cave_rooms(room_type, number_of_rooms)
    rooms = []
    number_of_rooms.times do 
      rooms << room_type
    end

    rooms
  end

end