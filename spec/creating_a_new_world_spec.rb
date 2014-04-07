require 'require_all'
require_all 'lib'

describe HuntTheWumpus do
  describe "Attempting to start a new game with a cave size that is too small" do
    it "errors out" do
      expect { game = HuntTheWumpus.new(9) }.to raise_error(CaveTooSmallError)
    end
  end

  describe "Attempting to start a new game with a cave size that is too large" do
    it "errors out" do
      expect { game = HuntTheWumpus.new(21) }.to raise_error(CaveTooLargeError)
    end
  end

  describe "Starting a new game of Hunt the Wumpus" do
    before :each do
      @game = HuntTheWumpus.new(10)
    end

    it "starts the game" do
      @game.ongoing?.should == true
    end
  end
  
  describe "Starting a game with a specific cave size" do
    before :each do
      @game = HuntTheWumpus.new(20)
    end

    it "Creates a cave of that size" do
      rows = @game.status.map
      rows.size.should == 20
      rows.each do |row|
        row.size.should == 20
      end
    end
  end
end