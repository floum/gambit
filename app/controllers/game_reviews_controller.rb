class GameReviewsController < ApplicationController
  before_action :set_game_review, only: %i[ show edit update destroy ]

  def index
    @game_reviews = GameReview.all
  end

  def show
  end

  def new
    @game_review = GameReview.new
  end

  def edit
  end

  def create
    @game_review = GameReview.new(game: Game.find(game_review_params[:game_id]))

    respond_to do |format|
      if @game_review.save
        format.html { redirect_to @game_review, notice: "Game training was successfully created." }
        format.json { render :show, status: :created, location: @game_review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @game_review.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @game_review.update(game_review_params)
        format.html { redirect_to @game_review, notice: "Game training was successfully updated." }
        format.json { render :show, status: :ok, location: @game_review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @game_review.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @game_review.destroy!

    respond_to do |format|
      format.html { redirect_to game_reviews_path, status: :see_other, notice: "Game training was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_review
      @game_review = GameReview.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_review_params
      params.require(:game_review).permit(:game_id)
    end
end
