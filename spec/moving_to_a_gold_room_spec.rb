require 'require_all'
require_all 'lib'

describe "Moving the player into a room with gold" do
  before :all do
    CaveGenerator.always_generate_this_hardcoded_cave("
      e.........
      $.........
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

  it "tells you there is gold in this room" do
    @game.status.messages.should include(:you_see_gold)
  end

  it "does not award us points" do
    @game.status.points.should == 0
  end
end

