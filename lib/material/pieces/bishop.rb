module Material
  class Bishop < Piece

    def inspect
      @color == :white ? "♗" : "♝"
    end
  end
end