require 'require_all'
require_all 'lib'

describe CaveGenerator do
  describe "Creating a random cave" do
    cave = CaveGenerator.generate_a_cave(10)
    rooms_to_generate_with_size_10_and_15_percent_chance = 10*10*15/100
    rooms_to_generate_with_size_10_and_FIVE_percent_chance = 10*10*5/100

    it "has 1 entrance" do
      cave.flatten.select { |x| x == :entrance }.size.should == 1
    end

    it "has weapons rooms with 15% chance" do
      cave.flatten.select { |x| x == :weapon }.size.should == rooms_to_generate_with_size_10_and_15_percent_chance
    end

    it "has gold rooms with 15% chance" do
      cave.flatten.select { |x| x == :gold }.size.should == rooms_to_generate_with_size_10_and_15_percent_chance
    end

    it "has wumpus with 15% chance" do
      cave.flatten.select { |x| x == :wumpus }.size.should == rooms_to_generate_with_size_10_and_15_percent_chance
    end
    it "has pitfall traps with 5% chance" do
      cave.flatten.select { |x| x == :pitfall }.size.should == rooms_to_generate_with_size_10_and_FIVE_percent_chance
    end

    it "has exactly the right number of rooms" do
      cave.flatten.size.should == 10*10
    end

  end  
end