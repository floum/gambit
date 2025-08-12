class GameReviewMove < ApplicationRecord
  belongs_to :game_review
  belongs_to :move

  def before
    move.before
  end

  delegate :san, to: :move
end
