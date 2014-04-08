require_relative 'spec_helper'
require 'require_all'
require_all 'lib'

describe "Approaching a wumpus armed" do
  before :all do
    @game = Context.create_game_with_cave("
      e
      t
      W")
    @game.receive_command(:move_south)
    @game.receive_command(:loot)

    @game.receive_command(:move_south)
  end

  it "does not tell us we were eaten" do
    @game.status.messages.should_not include(:you_are_eaten)
  end

  it "tells us slew a wumpus" do
    @game.status.messages.should include(:you_slew_a_wumpus)
  end

  it "awards us points for slaying a wumpus" do
    #we should already have 5 points for picking up the weapon
    @game.status.points.should == 5 + 10
  end

  it "does not tell us the game is over" do
    @game.ongoing?.should be_true
  end
end
