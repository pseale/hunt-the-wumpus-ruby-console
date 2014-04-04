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
    it "tells you you moved" do
      @game.status.messages.should include(:you_moved)
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

    after :all do
      CaveGenerator.reset_behavior_to_normal
    end
   end 

  describe "Moving the player west" do
    before :all do
      CaveGenerator.always_generate_this_hardcoded_cave("
        .e........
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

      @game.receive_command(:move_west)
    end
 
    it "moves the player one spot to the west" do
      @game.status.map[0][0].should == :player
    end

    after :all do
      CaveGenerator.reset_behavior_to_normal
    end
  end 

  describe "Moving the player east" do
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

      @game.receive_command(:move_east)
    end
 
    it "moves the player one spot to the east" do
      @game.status.map[0][1].should == :player
    end

    after :all do
      CaveGenerator.reset_behavior_to_normal
    end
  end

  describe "Attempting to move into a wall" do
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

      @game.receive_command(:move_west)
    end

    it "does not move the player" do
      @game.status.map[0][0].should == :player
    end

    it "tells us we hit a wall" do
      @game.status.messages.should include(:ran_into_a_wall)
    end

    it "doesn't tell us we moved" do
      @game.status.messages.should_not include(:you_moved)
    end

    after :all do
      CaveGenerator.reset_behavior_to_normal
    end
  end 

  describe "Moving the player into a room with gold" do
    before :all do
      CaveGenerator.always_generate_this_hardcoded_cave("
        e.........
        $.........
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

    it "tells you you moved" do
      @game.status.messages.should include(:you_moved)
    end

    it "tells you there is gold in this room" do
      @game.status.messages.should include(:you_see_gold)
    end


    after :all do
      CaveGenerator.reset_behavior_to_normal
    end
  end
end