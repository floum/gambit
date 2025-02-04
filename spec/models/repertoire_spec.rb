require 'rails_helper'

RSpec.describe Repertoire do
  it 'cannot have two moves from the same position' do
    r = Repertoire.new
    move = Move.new(before: 'abcde', uci: 'e2e4')
    alt_move = Move.new(before: 'abcde', uci: 'd2d4')

    r.repertoire_moves << RepertoireMove.new(move: move)
    expect(r.save).to be_truthy

    r.repertoire_moves << RepertoireMove.new(move: alt_move)

    expect(r.save).not_to be_truthy
  end
end
