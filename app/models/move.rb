class Move < ApplicationRecord
  after_create :analyze_move

  has_many :move_analysis

  def sheet_notation
    "#{number}.#{ color == 'b' ? '..' : ''}#{san}"
  end

  def white?
    color == 'white'
  end

  def black?
    !white?
  end

  def number
    before.split(" ").last.to_i
  end

  def color
    before.split(" ")[1] == 'w' ? 'white' : 'black'
  end

  def analyze_move
    MoveAnalysisJob.perform_later self
  end

  def cpl
    move_analysis.max_by do |analysis|
      analysis.depth
    end.value * -1
  end

  def evaluation
    value
  end
end
