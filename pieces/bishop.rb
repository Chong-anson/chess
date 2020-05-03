require_relative "sliding_piece"

class Bishop < Piece 
  include Slideable
  attr_reader :symbol 

  def initialize(color, board, position)
    super(color, board, position)
    @symbol = :B 
  end

  def move_dirs
    ["d"]
  end

  def to_s 
    "B"
  end 
  
end