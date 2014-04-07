require 'require_all'
require_all 'lib'

require 'pry'

describe "Attempting to loot an empty room" do
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

    @game.receive_command(:loot)
  end

  it "should tell you you failed to loot" do
    @game.status.messages.count.should == 1
    @game.status.messages[0].should == :you_failed_to_loot
  end

  it "should not award any extra points" do
    #should have 1 point already for exploring an empty room
    @game.status.points.should == 1 + 0
  end
end

describe "Attempting to loot the cave entrance" do
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

    @game.receive_command(:loot)
  end

  it "should tell you you failed to loot" do
    @game.status.messages.count.should == 1
    @game.status.messages[0].should == :you_failed_to_loot
  end

  it "should not award any extra points" do
    @game.status.points.should == 0
  end
end

describe "Looting gold" do
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

    @game.receive_command(:loot)
  end

  it "awards 5 points" do
    @game.status.points.should == 5
  end
end

describe "Moving away from a looted room" do
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
    @game.receive_command(:loot)

    @game.receive_command(:move_north)
  end

  it "shows the looted room as empty" do
    @game.status.map[1][0].should == :empty
  end
end

describe "Looting a weapon when unarmed" do
  before :all do
    CaveGenerator.always_generate_this_hardcoded_cave("
      ettttttttt
      tttttttttt
      tttttttttt
      tttttttttt
      tttttttttt
      tttttttttt
      tttttttttt
      tttttttttt
      tttttttttt
      tttttttttt")
    @game = HuntTheWumpus.new(10)
    #explore entire map so our test can "see" that there are no weapon rooms left.
    10.times do 
      9.times { @game.receive_command(:move_south) }
      9.times { @game.receive_command(:move_north) }
      @game.receive_command(:move_east)
    end      
    9.times { @game.receive_command(:move_east) }

    @game.receive_command(:move_south)

    @game.receive_command(:loot)
  end
  it "tells you you pick up the weapon" do
    @game.status.messages.should include(:looted_weapon)
  end

  it "arms you with the weapon" do
    @game.status.armed.should be_true
  end

  it "awards 5 points" do
    @game.status.points.should == 5
  end

  it "changes any weapon rooms to gold rooms" do
    @game.status.map.each do |row|
      row.should_not include(:weapon)
    end
  end
end
