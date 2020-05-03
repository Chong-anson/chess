require_relative "piece"
require "singleton"

class NullPiece < Piece
  include Singleton 
  attr_accessor :color, :symbol

  def initialize 
    @color = 0 
    @symbol = :N
  end

  def moves
    
  end 

  def to_s
    "_"
  end 
end