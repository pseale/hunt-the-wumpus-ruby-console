class Scoreboard
  attr_reader :points
  def initialize
    @points = 0
  end

  def we_looted
    @points += 5
  end

  def we_explored_an_empty_room
    @points += 1
  end
end