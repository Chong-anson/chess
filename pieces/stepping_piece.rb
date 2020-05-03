module Stepable 
  def moves 
    move_diffs.select do |pos|
      /[0-7][0-7]/ =~ pos.join &&
      ( board[pos].color == 0 ||
      board[pos].color == - color )
    end
  end 

  private 
  def move_diffs
    raise "Move_diffs is not created"
  end
end