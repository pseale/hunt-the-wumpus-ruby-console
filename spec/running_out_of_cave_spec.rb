require_relative 'spec_helper'
require 'require_all'
require_all 'lib'

describe "Running out of the cave to safety" do
  before :all do
    @game = Context.create_game_with_empty_cave

    @game.receive_command(:run)
  end

  it "tells us the game is over" do
    @game.ongoing?.should be_false
  end

  it "tells us we escape the cave" do
    @game.final_status.messages.should include(:you_escape)
  end

  it "tells us our final score" do
    @game.final_status.points.should == 0
  end
end
