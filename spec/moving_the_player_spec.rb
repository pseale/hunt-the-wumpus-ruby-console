require 'require_all'
require_all 'lib'

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

  it "does not award us points" do
    @game.status.points.should == 0
  end
end 

describe "Moving the player to a previously explored room" do
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
    @game.receive_command(:move_north)

    @game.receive_command(:move_south)
  end

  it "does not award any extra points" do
    @game.status.points.should == 1
  end
end
