class RepertoireMovesController < ApplicationController
  def destroy
    @repertoire_move = RepertoireMove.find(params[:id])
    @repertoire = @repertoire_move.repertoire
 
    @repertoire_move.destroy

    redirect_to repertoire_path(@repertoire)
  end
end
