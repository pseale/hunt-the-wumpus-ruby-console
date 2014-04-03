require 'require_all'
require_all 'lib'

describe HuntTheWumpus do
  describe "Displaying the game status" do
    game = HuntTheWumpus.new(10)

    it "creates a cave" do
      rows = game.status.map
      rows.size.should == 10
      rows.each do |row|
        row.size.should == 10
      end
    end

    it "has the player character somewhere in the cave" do
      game.status.map.flatten.should include(:player)
    end
  end
end