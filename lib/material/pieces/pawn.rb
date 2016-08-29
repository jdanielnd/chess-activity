module Material
  class Pawn < Piece

    def inspect
      self.color == :white ? "♙" : "♟"
    end
  end
end