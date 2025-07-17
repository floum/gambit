require 'rails_helper'

RSpec.describe "game_trainings/edit", type: :view do
  let(:game_training) {
    GameTraining.create!(
      game: nil
    )
  }

  before(:each) do
    assign(:game_training, game_training)
  end

  it "renders the edit game_training form" do
    render

    assert_select "form[action=?][method=?]", game_training_path(game_training), "post" do

      assert_select "input[name=?]", "game_training[game_id]"
    end
  end
end
