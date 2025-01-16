class RepertoireMoveValidator < ActiveModel::Validator
  def validate(record)
    if record.repertoire.moves.any? { |rm| rm.before == record.before }
      record.errors.add :before, "There is already a Move with that same position"
    end
  end
end
