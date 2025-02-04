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
    end.each do |move_info|
      move = Move.find_or_create_by(
        after: move_info["after"],
        before: move_info["before"],
        san: move_info["san"],
        uci: move_info["lan"]
      )
      rm = RepertoireMove.create(move: move, repertoire: @repertoire)
      p rm.errors
    end
  end

  def train
    @repertoire = Repertoire.find(params[:id])
  end

  def focus
    @repertoire = Repertoire.find(params[:id])
  end

  def export
    @repertoire = Repertoire.find(params[:id])
    render json: @repertoire, include: :moves
  end

  def import
    Repertoire.import(JSON.parse(File.read(params[:json_file])))
    redirect_to repertoires_path
  end

  private

  def repertoire_params
    params.require(:repertoire).permit(:name, :white, :precision)
  end
end
