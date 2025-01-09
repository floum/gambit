require 'rails_helper'

RSpec.describe Repertoire do
  it 'cannot save twice a RepertoirePosition from the same position' do
    pos = Position.create(fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1')
    rep = Repertoire.create()

    RepertoirePosition.create(repertoire: rep, position: pos)

    rep_pos = RepertoirePosition.create(repertoire: rep, position: pos)
    expect(rep_pos.save).to be_falsey
  end
end
