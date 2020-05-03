require_relative "board" 
require_relative "display"
require_relative "player"

class Game 
    attr_reader :board
    def initialize
        
        @board = Board.new 
        @display = Display.new(board)
        @players = [ HumanPlayer.new(1, display), HumanPlayer.new(-1, display)]
        @curr_player = players.first
    end 

    def play 
        game_over = false 
        until game_over
            begin 
                color = curr_player.color 
                color = ( color == 1 ? "Blue" : "Red")
                puts "It's #{color}'s player's turn" 
                start_pos, end_pos = curr_player.make_move
                board.move_piece(start_pos, end_pos) 
            rescue 
                puts "Your move is invalid"
                retry
            end
            switch_player
            @curr_player = players.first
            puts "player switched"
            players.each { |player| game_over = true if board.checkmate?(player.color)}

        end 
        p "End Game"
    end 
    
    private 
    def switch_player 
        @players.rotate!
    end 

    attr_reader :curr_player, :players, :display
end 