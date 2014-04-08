require_relative 'spec_helper'
require 'require_all'
require_all 'lib'

describe "Moving near a wumpus" do
  before :all do
    @game = Context.create_game_with_cave("
      e
      .
      W")

    @game.receive_command(:move_south)
  end

  it "does not tell us there is a howling wind" do
    @game.status.messages.should_not include(:there_is_a_howling_wind)
  end

  it "tells us there is a foul odor" do
    @game.status.messages.should include(:there_is_a_foul_odor)
  end
end
