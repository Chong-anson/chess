# chess
Chess game written in Ruby following strict OOP principles 

### Use of mixins && encapsulation
```
module Slideable
  def moves
    possible_moves = []
    move_dirs.each do |dir|
      case dir
      when "h"
        possible_moves.concat(horizontal_dirs)
      when "d"
        possible_moves.concat(diagonal_dirs)
      end
    end
    possible_moves
  end 

  def horizontal_dirs
    possible_moves = []
    @@HORIZONTAL_DIRS.each do |dx, dy|
      possible_moves.concat(grow_unblocked_moves_in_dir(dx , dy))
    end
    possible_moves
  end

  def diagonal_dirs
    possible_moves = []
    @@DIAGONAL_DIRS.each do |dx, dy|
      possible_moves.concat(grow_unblocked_moves_in_dir(dx , dy))
    end
    possible_moves
  end

  private
  @@HORIZONTAL_DIRS = [[1, 0], [-1, 0], [0, 1], [0, -1]]
  @@DIAGONAL_DIRS = [[1, 1], [-1, 1], [1, -1], [-1, -1]]

  def move_dirs
    raise "This method should be overwritten"
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    curr_pos = position.dup
    possible_moves = [] 
    #position = [1,1]
    while true 
      curr_pos = [curr_pos[0] + dx, curr_pos[1] + dy]
      break unless /[0-7][0-7]/ =~ curr_pos.join && curr_pos != position
      
      if board[curr_pos].color == color
        break
      elsif  board[curr_pos].color == - color 
        return possible_moves << curr_pos
      end
      possible_moves << curr_pos       
    end 

    possible_moves
  end

end
```
