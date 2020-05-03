require_relative "all_pieces" 
require "byebug"

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    fill_board
  end

  def print 
    grid.each do | row | 
      puts row.join(" ") 
    end 
    nil
  end 
  
  def [](position) 
    x, y = position
    grid[x][y] 
  end

  def []=(pos, val)
    x, y = pos
    grid[x][y] = val
  end

  def move_piece(start_pos, end_pos)
    current_piece = self[start_pos]
    target_position = self[end_pos]
    raise "No piece found at starting position" if self[start_pos].is_a?(NullPiece)
    raise "End position already occupied" if target_position.color == current_piece.color
    raise "Will move in check" if current_piece.move_into_check?(end_pos)
    # debugger 
    if current_piece.valid_moves.include?(end_pos)
      self[end_pos] = current_piece
      self[start_pos] = NullPiece.instance
      self[end_pos].position = end_pos
      puts "the #{self[end_pos].to_s} is at #{end_pos} now" 
    end 
  end 

  def valid_pos?(position)
    position.all? { |po| (0..7).include?(po)}
  end 
  
  def in_check?(color)

    king_pos = find_king(color)
    puts "#{color}'s king and position: #{king_pos}"

    (0..7).each do | row | 
      (0..7).each do | col | 
        piece = grid[row][col]
        next if piece.moves.nil? 
        return true if piece.moves.include?(king_pos) && piece.color == - color 
      end 
    end 

    false 
  end 

  def find_king(color)
    king_pos = nil 
    (0..7).each do | row | 
      (0..7).each do | col | 
        piece = grid[row][col] 
        next if piece.is_a?(NullPiece)
        king_pos = [row,col] if piece.symbol == :K && piece.color == color 
      end 
    end 
    king_pos 
  end 



  def checkmate?(color)
    if in_check?(color)
      (0..7).each do | row | 
        (0..7).each do | col | 
          piece = grid[row][col]
          next if piece.moves.nil? 
          return false if piece.moves.length > 0 && piece.color == color 
        end 
      end 
      true 
    else
      false
    end
  end 

  def dup 
    new_board = Board.new
    (0..7).each do | row | 
      (0..7).each do | col | 
        piece = grid[row][col] 
        case piece.symbol 
        when :K
          new_board[[row,col]] = King.new(piece.color, new_board, piece.position)
        when :B
          new_board[[row,col]] = Bishop.new(piece.color, new_board, piece.position)
        when :T
          new_board[[row,col]] = Knight.new(piece.color, new_board, piece.position)
        when :P 
          new_board[[row,col]] = Pawn.new(piece.color, new_board, piece.position)
        when :Q
          new_board[[row,col]] = Queen.new(piece.color, new_board, piece.position)
        when :R
          new_board[[row,col]] = Rook.new(piece.color, new_board, piece.position)
        when :N
          new_board[[row,col]] = NullPiece.instance
        end 
      end 
    end 
    new_board
  end 

  
  private
  

  def fill_board
        grid[0] = [Rook.new(1, self, [0,0]), Knight.new(1, self, [0,1]), Bishop.new(1, self, [0,2]),
         Queen.new(1, self, [0,3]), King.new(1, self, [0,4]), Bishop.new(1, self, [0,5]), 
         Knight.new(1, self, [0,6]), Rook.new(1, self, [0,7])]
        grid[1].map!.with_index { | ele, i | Pawn.new(1, self, [1,i])}
        (2..5).each do | row | 
          grid[row].map! { NullPiece.instance }
        end 
        grid[6].map!.with_index { | ele, i | Pawn.new(-1, self, [6,i])}
        grid[7] = [Rook.new(-1, self, [7,0]), Knight.new(-1, self, [7,1]), Bishop.new(-1, self, [7,2]),
         Queen.new(-1, self, [7,3]), King.new(-1, self, [7,4]), Bishop.new(-1, self, [7,5]), 
         Knight.new(-1, self, [7,6]), Rook.new(-1, self, [7,7])] 
  end


  def inspect 
    self.print 
  end 
end

# $b = Board.new
# $b.print 
# $b.move_piece([6,5],[5,5])
# $b.move_piece([1,4],[3,4])
# $b.move_piece([6,6],[4,6])
# $b.move_piece([0,3],[4,7])

# p "________________"
# $b.print 
# p "1 is in check?"
# p $b.in_check?(1) 
# p "-1 is in check?"
# p $b.in_check?(-1) 
