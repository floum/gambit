class RepertoiresController < ApplicationController
  def index
    @repertoires = Repertoire.all
  end

  def show
    @repertoire = Repertoire.find(params[:id])
  end

  def edit
    @repertoire = Repertoire.find(params[:id])
  end
end
