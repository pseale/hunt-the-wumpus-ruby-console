require_relative 'spec_helper'
require 'require_all'
require_all 'lib'

describe "Approaching a wumpus unarmed" do
  before :all do
    @game = ObjectMother.create_game_with_cave("
      e
      W")

    @game.receive_command(:move_south)
  end

  it "tells us we were eaten by a wumpus" do
    @game.final_status.messages.should include(:you_are_eaten)
  end

  it "tells us the game is over" do
    @game.ongoing?.should be_false
  end
end
