require_relative "stepping_piece"

class King < Piece
  include Stepable
  attr_reader :symbol 

  def initialize(color,board, position)
    super
    @symbol = :K
  end

  def move_diffs
    diffs = [[-1,-1],[0,-1],[1,-1],[-1,0],[1,0],[-1,1],[0,1],[1,1]]
    diffs.map { |move| [move.first + position.first, move.last + position.last]}
  end
  

  def to_s  
    "K"
  end 

  def inspect 
    "K"
  end 
end