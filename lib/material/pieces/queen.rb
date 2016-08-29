module Material
  class Queen < Piece

    def inspect
      self.color == :white ? "♕" : "♛"
    end    
  end
end