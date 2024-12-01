class RepertoirePositionsController < ApplicationController
  def destroy
    @repertoire_position = RepertoirePosition.find(params[:id])
    @repertoire = @repertoire_position.repertoire
    @repertoire_position.destroy

    redirect_to repertoire_path(@repertoire)
  end
end
