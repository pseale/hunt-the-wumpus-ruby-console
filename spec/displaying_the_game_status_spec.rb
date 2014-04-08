require_relative 'spec_helper'
require 'require_all'
require_all 'lib'

describe "Displaying the game status" do
  before :each do
    @game = HuntTheWumpus.new(10)
  end

  it "displays a cave" do
    rows = @game.status.map
    rows.size.should == 10
    rows.each do |row|
      row.size.should == 10
    end
  end

  it "has the player character somewhere in the cave" do
    @game.status.map.flatten.should include(:player)
  end

  describe "At the beginning of the game" do
    it "is completely unexplored" do
      list_of_rooms = @game.status.map.flatten.uniq
      list_of_rooms.delete(:player)
      list_of_rooms.size.should == 1
      list_of_rooms[0].should == :unexplored
    end
  end
end
