require 'require_all'
require_all 'lib'

require 'pry'

describe "Moving the player into a room with a weapon" do
  before :all do
    CaveGenerator.always_generate_this_hardcoded_cave("
      e.........
      t.........
      ..........
      ..........
      ..........
      ..........
      ..........
      ..........
      ..........
      ..........")
    @game = HuntTheWumpus.new(10)

    @game.receive_command(:move_south)
  end

  it "tells you you moved" do
    @game.status.messages.should include(:you_moved)
  end

  it "tells you there is a weapon in this room" do
    @game.status.messages.should include(:you_see_a_weapon)
  end

  it "does not award us points" do
    @game.status.points.should == 0
  end
end
