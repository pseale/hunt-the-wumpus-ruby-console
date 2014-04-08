require_relative 'spec_helper'
require 'require_all'
require_all 'lib'

describe "Moving the player to an empty room" do
  before :all do
    @game = Context.create_game_with_empty_cave

    @game.receive_command(:move_south)
  end

  it "awards 1 point for exploring a new, empty room" do
    @game.status.points.should == 1
  end
end
