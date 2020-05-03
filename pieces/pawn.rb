class Pawn < Piece
  attr_reader :symbol 

  def initialize(color, board, position)
    super
    @symbol = :P
  end

  def moves 
    # forwards = [row,col, [], []]
    possible_moves = forward_steps + side_attacks
    possible_moves
  end 

  private
  def at_start_row?
    (color == 1 && position[0] == 1) || (color == -1 && position[0] == 6)
  end

  def forward_dir
    color
  end

  def forward_steps
    row, col = position
    if board[[row + forward_dir, col]].color == color  
      return [] 
    elsif at_start_row? && board[[row + (forward_dir * 2), col]].color != color 
      return [[row + forward_dir, col], [row + (forward_dir * 2), col]]
    else
      return [[row + forward_dir, col]]
    end
  end

  def side_attacks
    row, col = position
    [[row + forward_dir, col + forward_dir], 
    [row + forward_dir, col - forward_dir]].select do |pos|
      /[0-7][0-7]/ =~ pos.join
    end.select { | pos | board[pos].color == - color } 
  end
  
end