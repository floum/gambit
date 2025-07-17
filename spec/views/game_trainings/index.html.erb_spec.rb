require 'rails_helper'

RSpec.describe "game_trainings/index", type: :view do
  before(:each) do
    assign(:game_trainings, [
      GameTraining.create!(
        game: nil
      ),
      GameTraining.create!(
        game: nil
      )
    ])
  end

  it "renders a list of game_trainings" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
