require_relative 'spec_helper'
require 'require_all'
require_all 'lib'

describe "Falling into a pitfall" do
  before :all do
    @game = Context.create_game_with_cave("
      e
      p")

    @game.receive_command(:move_south)
  end

  it "tells us we fell into a pitfall" do
    @game.final_status.messages.should include(:you_fall)
  end

  it "tells us the game is over" do
    @game.ongoing?.should be_false
  end
end
