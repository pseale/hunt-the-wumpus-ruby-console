require_relative 'spec_helper'
require 'require_all'
require_all 'lib'

describe "Leaving a slain wumpus" do
  before :all do
    @game = ObjectMother.create_game_with_cave("
      e
      t
      W")
    @game.receive_command(:move_south)
    @game.receive_command(:loot)
    @game.receive_command(:move_south)

    @game.receive_command(:move_north)

  end

  it "shows the room with the slain wumpus as empty now" do
    @game.status.map[2][0].should == :empty
  end
end
