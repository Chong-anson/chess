class Rook < Piece
  include Slideable
  attr_reader :symbol 

  def initialize(color, board, position)
    super
    @symbol = :R
  end

  def move_dirs
    ["h"]
  end

  def to_s
    "R"
  end 
  
end