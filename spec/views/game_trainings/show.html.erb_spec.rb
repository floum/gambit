require 'rails_helper'

RSpec.describe "game_trainings/show", type: :view do
  before(:each) do
    assign(:game_training, GameTraining.create!(
      game: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
  end
end
