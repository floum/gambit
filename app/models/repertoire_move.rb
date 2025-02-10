class RepertoireMove < ApplicationRecord
  belongs_to :move
  belongs_to :repertoire

  has_many :attempts, class_name: 'RepertoireMoveAttempt', dependent: :destroy

  delegate :before, to: :move, prefix: false
  delegate :after, to: :move, prefix: false
  delegate :san, to: :move, prefix: false
  delegate :uci, to: :move, prefix: false
  delegate :sheet_notation, to: :move, prefix: false

  validates_with RepertoireMoveValidator

  def success_rate
    self.attempts.select(&:success?).size.to_f / self.attempts.size
  end

  def last_attempted_at
    attempts.pluck(:created_at).max
  end
end
