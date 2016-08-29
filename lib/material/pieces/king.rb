module Material
  class King < Piece

    def inspect
      self.color == :white ? "♔" : "♚"
    end
  end
end