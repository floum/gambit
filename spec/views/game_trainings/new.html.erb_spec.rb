require 'rails_helper'

RSpec.describe "game_trainings/new", type: :view do
  before(:each) do
    assign(:game_training, GameTraining.new(
      game: nil
    ))
  end

  it "renders new game_training form" do
    render

    assert_select "form[action=?][method=?]", game_trainings_path, "post" do

      assert_select "input[name=?]", "game_training[game_id]"
    end
  end
end
