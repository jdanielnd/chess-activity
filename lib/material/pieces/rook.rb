module Material
  class Rook < Piece

    def inspect
      self.color == :white ? "♖" : "♜"
    end    
  end
end