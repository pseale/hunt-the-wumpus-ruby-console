require 'require_all'
require_all 'lib'

require 'pry'

describe "Entering the cave immediately next to a wumpus" do
  before :all do
    CaveGenerator.always_generate_this_hardcoded_cave("
      eW........
      ..........
      ..........
      ..........
      ..........
      ..........
      ..........
      ..........
      ..........
      ..........")
    @game = HuntTheWumpus.new(10)
  end

  it "should indicate there is a foul stench in the air" do
    @game.status.messages.should include(:there_is_a_foul_odor)
  end
end

