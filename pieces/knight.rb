require_relative "stepping_piece"

class Knight < Piece
  include Stepable
  attr_reader :symbol 

  def initialize(color,board, position)
    super
    @symbol = :T
  end

  def move_diffs
    diffs = [[-2,-1],[-2,1],[-1,2],[-1,-2],[1,2],[1,-2],[2,1],[2,-1]]
    diffs.map { |move| [move.first + position.first, move.last + position.last]}
  end
  

  def to_s  
    "T"
  end 

  def inspect 
    "T"
  end 
end