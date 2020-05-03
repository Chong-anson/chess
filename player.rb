require_relative "cursor" 

class Player 
    attr_reader :color
    def initialize(color, display)
        @color = color 
        @display = display 

    end 
    private
    attr_reader :display

end 

class HumanPlayer < Player 
    def make_move 
        puts "Please select a piece"
        begin 
            chosen_position = display.render(color)
            chosen_piece = display.board[chosen_position]
            raise if chosen_piece.color != color 
        rescue 
            puts  "It's not your piece"
            retry 
        end 
        puts "You have select the #{chosen_piece}"
        puts "Where would you like to move to"
        # sleep(1) 
        destination = display.render(color)
        return [chosen_position, destination]
    end 

end 