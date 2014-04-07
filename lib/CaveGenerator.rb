class CaveGenerator
  @@cave_layout_string = nil

  def self.always_generate_this_hardcoded_cave(cave_layout_string)
    @@cave_layout_string = cave_layout_string
  end

  def self.reset_behavior_to_normal
    @@cave_layout_string = nil
  end

  def self.generate_a_cave(size)
    if @@cave_layout_string
      generate_a_cave_from_template
    else
      generate_a_cave_randomly(size)
    end
  end

  @@template_map = {
    "." => :empty,
    "e" => :entrance,
    "$" => :gold,
    "t" => :weapon,
    "W" => :wumpus,
    "p" => :pitfall
  }
  def self.generate_a_cave_from_template
    rooms = []
    keys = @@template_map.keys

    @@cave_layout_string.split("").each do |candidate_room|
      rooms.unshift @@template_map[candidate_room] if keys.include? candidate_room
    end

    Cave.new(rooms, Math.sqrt(rooms.size).to_i)
  end

  def self.generate_a_cave_randomly(size)
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

    Cave.new(rooms, size)
  end

  def self.create_cave_rooms(room_type, number_of_rooms)
    rooms = []
    number_of_rooms.times do 
      rooms << room_type
    end

    rooms
  end
end