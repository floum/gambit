class RepertoireMovesController < ApplicationController
  def create
    @repertoire_move = RepertoireMove.new(repertoire_move_params)
    if @repertoire_move.save
      redirect_to repertoire_path(@repertoire_move.repertoire)
    end
  end

  private

  def repertoire_move_params
    params.require(:repertoire_move).permit(:move_id, :repertoire_position_id)
  end
end
