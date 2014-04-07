require 'require_all'
require_all 'lib'

describe "Moving into a pitfall" do
  before :all do

    CaveGenerator.always_generate_this_hardcoded_cave("
      e.........
      p.........
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

  it "tells us we fell into a pitfall" do
    @game.final_status.messages.should include(:you_fall)
  end

  it "tells us the game is over" do
    @game.ongoing?.should be_false
  end
end
