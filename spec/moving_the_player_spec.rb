require 'require_all'
require_all 'lib'

require 'pry'

describe HuntTheWumpus do
  describe "Moving the player" do
    before :all do
      CaveGenerator.always_generate_this_hardcoded_cave("
        e.........
        ..........
        ..........
        ..........
        ..........
        ..........
        ..........
        ..........
        ..........
        ..........")
      @game = HuntTheWumpus.new(10)

      @game.receive_command(:move_south)
    end

    it "moves the player to the new room" do
      @game.status.map[1][0].should == :player
    end
    it "reveals the contents of the previous room" do
      @game.status.map[0][0].should == :entrance
    end

    after :all do
      CaveGenerator.reset_behavior_to_normal
    end
  end

  describe "Moving the player north" do
    before :all do

      CaveGenerator.always_generate_this_hardcoded_cave("
        ..........
        e.........
        ..........
        ..........
        ..........
        ..........
        ..........
        ..........
        ..........
        ..........")
      @game = HuntTheWumpus.new(10)

      @game.receive_command(:move_north)
    end

    it "moves the player one spot to the north" do
      @game.status.map[0][0].should == :player
    end

    after :all do
      CaveGenerator.reset_behavior_to_normal
    end
  end

  describe "Moving the player south" do
    before :all do
      CaveGenerator.always_generate_this_hardcoded_cave("
        e.........
        ..........
        ..........
        ..........
        ..........
        ..........
        ..........
        ..........
        ..........
        ..........")
      @game = HuntTheWumpus.new(10)

      @game.receive_command(:move_south)
    end

    it "moves the player one spot to the south" do
      @game.status.map[1][0].should == :player
    end
  end 

  describe "Moving the player west" do
    it "moves the player one spot to the west"
  end 
  describe "Moving the player east" do
    it "moves the player one spot to the east"
  end 
end