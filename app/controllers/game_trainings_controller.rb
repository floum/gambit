class GameTrainingsController < ApplicationController
  before_action :set_game_training, only: %i[ show edit update destroy ]

  # GET /game_trainings or /game_trainings.json
  def index
    @game_trainings = GameTraining.all
  end

  # GET /game_trainings/1 or /game_trainings/1.json
  def show
  end

  # GET /game_trainings/new
  def new
    @game_training = GameTraining.new
  end

  # GET /game_trainings/1/edit
  def edit
  end

  # POST /game_trainings or /game_trainings.json
  def create
    game = Game.create(
      white: game_training_params[:white],
      black: game_training_params[:black],
      result: game_training_params[:result]
    )
    JSON.parse(game_training_params[:moves]).each do |move_params|
      move = Move.find_or_create_by(
        before: move_params['before'],
        after: move_params['after'],
        san: move_params['san'],
        uci: move_params['lan'],
      )
      GameMove.create(move:, game:)
    end
    @game_training = GameTraining.new(game:)

    respond_to do |format|
      if @game_training.save
        format.html { redirect_to @game_training, notice: "Game training was successfully created." }
        format.json { render :show, status: :created, location: @game_training }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @game_training.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game_trainings/1 or /game_trainings/1.json
  def update
    respond_to do |format|
      if @game_training.update(game_training_params)
        format.html { redirect_to @game_training, notice: "Game training was successfully updated." }
        format.json { render :show, status: :ok, location: @game_training }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @game_training.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_trainings/1 or /game_trainings/1.json
  def destroy
    @game_training.destroy!

    respond_to do |format|
      format.html { redirect_to game_trainings_path, status: :see_other, notice: "Game training was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_training
      @game_training = GameTraining.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_training_params
      params.require(:game_training).permit(:pgn, :moves, :white, :black, :result)
    end
end
