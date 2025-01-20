class Move < ApplicationRecord
  def sheet_notation
    "#{number}.#{ color == 'b' ? '..' : ''}#{san}"
  end

  def number
    before.split(' ').last
  end

  def color
    before.split(' ')[1]
  end
end
