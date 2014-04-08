require_relative 'spec_helper'
require 'require_all'
require_all 'lib'

describe "Entering the cave immediately next to a wumpus" do
  before :all do
    @game = Context.create_game_with_cave("eW")
  end

  it "should indicate there is a foul stench in the air" do
    @game.status.messages.should include(:there_is_a_foul_odor)
  end
end

