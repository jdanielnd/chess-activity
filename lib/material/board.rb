module Material
  class Board
    attr_accessor :fields, :pieces

    def initialize
      @fields = Array.new(8).map do |col|
        col = Array.new(8)
      end

      @pieces = []
    end

    def [](coord)
      fields[coord[1]][coord[0]]
    end

    def []=(coord, value)
      fields[coord[1]][coord[0]] = value
    end

    def dup
      @pieces.each_with_object(Board.new) do |piece, board_copy|
        board_copy[piece.position] = piece.dup(board_copy)
        board_copy.pieces << board_copy[piece.position]
      end
    end

    def empty?(x, y)
      self[[x,y]].nil?
    end

    def enemy?(x, y, color)
      self[[x,y]] && (self[[x,y]].color != color)
    end

    def setup
      @pieces = [
        King.new(:white, [4,7], self, false),
        Queen.new(:white, [3,7], self, false),
        Rook.new(:white, [0,7], self, false),
        Rook.new(:white, [7,7], self, false),
        Knight.new(:white, [1,7], self, false),
        Knight.new(:white, [6,7], self, false),
        Bishop.new(:white, [2,7], self, false),
        Bishop.new(:white, [5,7], self, false),
        Queen.new(:black, [3,0], self, false),
        King.new(:black, [4,0], self, false),
        Rook.new(:black, [0,0], self, false),
        Rook.new(:black, [7,0], self, false),
        Knight.new(:black, [1,0], self, false),
        Knight.new(:black, [6,0], self, false),
        Bishop.new(:black, [2,0], self, false),
        Bishop.new(:black, [5,0], self, false)
      ]

      (0..7).each do |x|
        @pieces << Pawn.new(:white, [x,6], self, false)
        @pieces << Pawn.new(:black, [x,1], self, false)
      end

      @pieces.each {|piece| self[piece.position] = piece}
    end

    def render
      display_board = Board.new.fields
      is_colored = false
      row_counter = 8
      display_board.each_with_index do |row, y|
        print " #{row_counter} "
        row.each_with_index do |square, x|
          if self[[x,y]].nil?
            row[x] = "   "
          else
            row[x] = " #{self[[x,y]].inspect} "
          end
          if is_colored
            row[x] = row[x].colorize(:background => :light_green)
            is_colored = false
          else
            row[x] = row[x].colorize(:background => :light_white)
            is_colored = true
          end
          print "#{row[x]}"
        end
        print "\n"
        is_colored = !is_colored
        row_counter -= 1
      end
      puts "    A  B  C  D  E  F  G  H "
    end

    def move(start_pos, end_pos)
      piece = self[start_pos]

      raise BadMoveError.new("There is no piece there!") if empty?(start_pos[0], start_pos[1])
      raise BadMoveError.new("Cannot move into check!") if moving_into_check?(start_pos, end_pos)
      
      if piece.valid_moves.include?(end_pos)
        move!(start_pos, end_pos)
      else
        raise BadMoveError.new("Invalid move for this piece!")
      end

    end

    def move!(start_pos, end_pos)
      piece = self[start_pos]
      piece.position, piece.moved = end_pos, true
      self[start_pos], self[end_pos] = nil, piece
      self
    end

    def moving_into_check?(start_pos, end_pos)
      board_copy = dup.move!(start_pos, end_pos)
      board_copy.in_check?(board_copy[end_pos].color)
    end

    def in_check?(color)
      king_pos = find_king(color).position
      pieces.any? do |piece|
        piece.color != color && piece.moves.include?(king_pos)
      end
    end

    def find_pieces(color)
      pieces.select { |piece| piece.color == color }
    end
    
    def find_king(color)
      find_pieces(color).find { |piece| piece.class == King }
    end

  end
end