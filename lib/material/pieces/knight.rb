module Material
  class Knight < Piece

    def inspect
      self.color == :white ? "♘" : "♞"
    end
  end
end