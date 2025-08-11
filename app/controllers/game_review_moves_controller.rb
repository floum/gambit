class GameReviewMovesController < ApplicationController
  def create
    @game_review = GameReview.find(game_review_move_params[:game_review_id])
    move_info = game_review_move_params[:move]
    @move = Move.find_or_create_by(
      after: move_info["after"],
      before: move_info["before"],
      san: move_info["san"],
      uci: move_info["lan"]
    )
    GameReviewMove.create(move: @move, game_review: @game_review)
  end

  private

  def game_review_move_params
    params.require(:game_review_move).permit(:game_review_id, move: [:before, :after, :san, :lan])
  end
end