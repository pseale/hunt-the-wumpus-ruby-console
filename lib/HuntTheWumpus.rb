require 'ostruct'

class CaveTooSmallError < StandardError; end
class CaveTooLargeError < StandardError; end

class HuntTheWumpus
  def initialize(cave_size)
    raise CaveTooSmallError if cave_size < 10
    raise CaveTooLargeError if cave_size > 20

    @cave_size = cave_size
  end

  def status
    cave = []
    
    (1..@cave_size).each do |row|
      cave_row = []
      (1..@cave_size).each do |col|
        cave_row << :unexplored
      end
      cave << cave_row
    end
    return OpenStruct.new(:map => cave)
  end

  def ongoing?
    true
  end
end