class Queen < Piece
  include Slideable
  attr_reader :symbol 
  def initialize(color,board, position)
    super
    @symbol = :Q
  end

  def move_dirs
    ["h", "d"]
  end

  def to_s  
    "Q"
  end 

  def inspect 
    "Q"
  end 
end