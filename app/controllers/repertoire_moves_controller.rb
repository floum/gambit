class RepertoireMovesController < ApplicationController
  def destroy
    @repertoire_move = RepertoireMove.find(params[:id])
    @repertoire = @repertoire_move.repertoire

    @repertoire_move.destroy

    redirect_to repertoire_path(@repertoire)
  end

  def attempt
    @repertoire_move = RepertoireMove.find(params[:id])
  end
end
