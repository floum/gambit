class RepertoiresController < ApplicationController
  def index
    @repertoires = Repertoire.all
  end

  def new
    @repertoire = Repertoire.new
  end

  def show
    @repertoire = Repertoire.find(params[:id])
  end

  def edit
    @repertoire = Repertoire.find(params[:id])
  end

  def create
    @repertoire = Repertoire.new(repertoire_params)
    if @repertoire.save
      redirect_to repertoires_path
    end
  end

  private

  def repertoire_params
    params.require(:repertoire).permit(:name, :white, :precision)
  end
end
