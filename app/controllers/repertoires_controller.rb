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

  def destroy
    @repertoire = Repertoire.find(params[:id])
    @repertoire.destroy

    redirect_to repertoires_path
  end

  def create
    @repertoire = Repertoire.new(repertoire_params)
    if @repertoire.save
      redirect_to repertoires_path
    end
  end

  def update
    @repertoire = Repertoire.find(params[:id])
    
    line = params[:line]

    line.select do |move|
      move["color"] == @repertoire.color[0]
    end.each do |move|
      from = Position.find_or_create_by(fen: move["before"])
      to = Position.find_or_create_by(fen: move["after"])
      move = Move.create(position: from, result: to, uci: move["lan"], san: move["san"])
      repertoire_position = RepertoirePosition.create(repertoire: @repertoire, position: from)
      RepertoireMove.create(repertoire_position: repertoire_position, move: move)
    end
  end

  private

  def repertoire_params
    params.require(:repertoire).permit(:name, :white, :precision)
  end
end
