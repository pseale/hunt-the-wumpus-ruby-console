require 'require_all'
require_all 'lib'

describe "Moving near a wumpus" do
  before :all do

    CaveGenerator.always_generate_this_hardcoded_cave("
      e.........
      ..........
      p.........
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

  it "does not tell us there is a foul stench in the air" do
    @game.status.messages.should_not include(:there_is_a_foul_odor)
  end

  it "tells us there is a howling wind" do
    @game.status.messages.should include(:there_is_a_howling_wind)
  end
end
