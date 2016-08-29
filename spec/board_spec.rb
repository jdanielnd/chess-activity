require 'spec_helper'

describe Material::Board do
  let(:board) { Material::Board.new }

  it 'has 64 fields' do
    expect(board.fields.flatten.size).to eq 64
  end

  it 'can assign pieces to fields' do
    piece = Material::Pawn.new(:white)
    board[1, 4] = piece

    expect(board[1, 4]).to eq piece
  end

  it 'starts with correct pieces' do

  end

end
