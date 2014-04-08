require_relative 'spec_helper'
require 'require_all'
require_all 'lib'

describe "Moving the player into a room with gold" do
  before :all do
    @game = Context.create_game_with_cave("
      e
      $")

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

