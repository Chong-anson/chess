require_relative "cursor"
require "colorize"

class Display
  attr_reader :board, :cursor
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render(color)
    symbol = {
      K: "\u2654",
      Q: "\u2655",
      R: "\u2656",
      B: "\u2657",
      T: "\u2658",
      P: "\u2659"
      }
      reset_cursor
      color = ( color == 1 ? "Blue" : "Red")
      while true
        system("clear")
        puts "-" * 20 
        puts "It's #{color}'s player's turn" 
        @board.grid.each.with_index do | row, i | 
          row.each.with_index do | ele , j|
            if cursor.cursor_pos == [i,j]
              print cursor.selected ? "\u25A0".yellow : "\u25A0".green
            elsif ele.color == 1 
              print symbol[ele.symbol].blue 
            elsif ele.color == -1 
              print symbol[ele.symbol].red
            else 
              print ele.to_s
            end 
            print " "
          end 
          print "\n"
        end 
        # debugger
        if cursor.selected
          break
        end 
        @cursor.get_input
        # puts "Wait!"
        # sleep(1)
      end 
      cursor.cursor_pos
  end

  private 
  def reset_cursor 
    cursor.toggle_selected if cursor.selected
  end 
end 

# d = Display.new($b) 
# d.render