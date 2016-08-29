require "material/version"
require "material/board"
require "material/piece"

require 'material/pieces/bishop'
require 'material/pieces/king'
require 'material/pieces/knight'
require 'material/pieces/pawn'
require 'material/pieces/queen'
require 'material/pieces/rook'

require 'colorize'

module Material
  class BadMoveError < StandardError
  end
end
