require 'rails_helper'

RSpec.describe Position do
  context 'when saved with a full fen' do
    it 'saves only the board state' do
      pos = Position.create(fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1')

      expect(pos.fen.split(' ').size).to eq 4
    end
  end
end
