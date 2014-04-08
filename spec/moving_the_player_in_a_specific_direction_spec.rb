require_relative 'spec_helper'
require 'require_all'
require_all 'lib'

describe "Moving the player north" do
  before :all do
    @game = Context.create_game_with_cave("
      .
      e")

    @game.receive_command(:move_north)
  end

  it "moves the player one spot to the north" do
    @game.status.map[0][0].should == :player
  end
end

describe "Moving the player south" do
  before :all do
    @game = Context.create_game_with_empty_cave

    @game.receive_command(:move_south)
  end

  it "moves the player one spot to the south" do
    @game.status.map[1][0].should == :player
  end
end 

describe "Moving the player west" do
  before :all do
    @game = Context.create_game_with_cave(".e")

    @game.receive_command(:move_west)
  end

  it "moves the player one spot to the west" do
    @game.status.map[0][0].should == :player
  end
end 

describe "Moving the player east" do
 before :all do
    @game = Context.create_game_with_empty_cave

    @game.receive_command(:move_east)
  end

  it "moves the player one spot to the east" do
    @game.status.map[0][1].should == :player
  end
end
