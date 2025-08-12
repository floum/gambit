class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def show
    @game = Game.find(params[:id])
  end

  def create
    @game = Game.create(
      white: game_params[:white],
      black: game_params[:black],
      result: game_params[:result],
      review_as_white: game_params[:review_as_white],
      review_size: game_params[:review_size]
    )
    JSON.parse(game_params[:moves]).each do |move_params|
      move = Move.find_or_create_by(
        before: move_params['before'],
        after: move_params['after'],
        san: move_params['san'],
        uci: move_params['lan'],
      )
      GameMove.create(move:, game: @game)
    end
    redirect_to games_path
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    redirect_to games_path
  end

  private
  
  def game_params
    params.require(:game).permit(:pgn, :white, :black, :result, :review_as_white, :review_size, :moves)
  end
end
