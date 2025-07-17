class GameMove < ApplicationRecord
  belongs_to :game
  belongs_to :move
end
