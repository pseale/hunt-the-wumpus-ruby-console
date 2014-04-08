require_relative 'spec_helper'
require 'require_all'
require_all 'lib'

describe CaveGenerator do
  describe "Creating a random cave" do
    before :all do
      @cave = CaveGenerator.generate_a_cave(10)
      @rooms_to_generate_with_size_10_and_15_percent_chance = 10*10*15/100
      @rooms_to_generate_with_size_10_and_FIVE_percent_chance = 10*10*5/100
      @generated_rooms = []
      (0..@cave.size-1).each do |row|
        (0..@cave.size-1).each do |col|
          @generated_rooms << @cave[row, col]
        end
      end
    end

    it "has 1 entrance" do
      @generated_rooms.select { |x| x == :entrance }.size.should == 1
    end

    it "has weapons rooms with 15% chance" do
      @generated_rooms.select { |x| x == :weapon }.size.should == @rooms_to_generate_with_size_10_and_15_percent_chance
    end

    it "has gold rooms with 15% chance" do
      @generated_rooms.select { |x| x == :gold }.size.should == @rooms_to_generate_with_size_10_and_15_percent_chance
    end

    it "has wumpus rooms with 15% chance" do
      @generated_rooms.select { |x| x == :wumpus }.size.should == @rooms_to_generate_with_size_10_and_15_percent_chance
    end
    it "has pitfall traps with 5% chance" do
      @generated_rooms.select { |x| x == :pitfall }.size.should == @rooms_to_generate_with_size_10_and_FIVE_percent_chance
    end

    it "has exactly the right number of rooms" do
      @generated_rooms.size.should == 10*10
    end
  end  
end