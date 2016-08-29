module Material
  class Piece
    attr_accessor :color, :position, :board, :moved

    def initialize(color, position, board, moved)
      @color = color
      @position = position
      @board = board
      @moved = false
    end

  end
end