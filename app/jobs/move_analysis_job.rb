class MoveAnalysisJob < ApplicationJob
  queue_as :default

  DEPTH = 18

  def multiplier(move)
    if move.color == 'black'
      - 1
    else
      1
    end
  end

  def perform(move)
    before_analysis = Stockfish.analyze move.before, { :depth => DEPTH }
    after_analysis = Stockfish.analyze move.after, { :depth => DEPTH }

    before_score = multiplier(move) * before_analysis[:variations][0][:score]
    after_score = -1 * multiplier(move) * after_analysis[:variations][0][:score]

    value = multiplier(move) * (after_score - before_score)
    MoveAnalysis.create(move: move, value: [0, value.round(2)].min, depth: DEPTH)
  end
end
