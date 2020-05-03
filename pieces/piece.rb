class Piece
  attr_accessor :position 
  attr_reader :color, :board 

  def initialize(color, board, position)
    @color = color      # 1 or -1 
    @board = board 
    @position = position 
  end

  def to_s 
    "P"  
  end 

  def empty?

  end 

  def valid_moves
    possible_moves = moves  
    # p possible_moves
    possible_moves.reject { |move| move_into_check?(move) }
  end

  def symbol
    :P
  end 


  def move_into_check?(end_pos)
    new_board = board.dup
    current_piece = new_board[position]
    new_board[end_pos] = current_piece
    new_board[position] = NullPiece.instance
    
    new_board.checkmate?( color )
  end
  
    private 
end