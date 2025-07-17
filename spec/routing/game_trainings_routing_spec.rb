require "rails_helper"

RSpec.describe GameTrainingsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/game_trainings").to route_to("game_trainings#index")
    end

    it "routes to #new" do
      expect(get: "/game_trainings/new").to route_to("game_trainings#new")
    end

    it "routes to #show" do
      expect(get: "/game_trainings/1").to route_to("game_trainings#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/game_trainings/1/edit").to route_to("game_trainings#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/game_trainings").to route_to("game_trainings#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/game_trainings/1").to route_to("game_trainings#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/game_trainings/1").to route_to("game_trainings#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/game_trainings/1").to route_to("game_trainings#destroy", id: "1")
    end
  end
end
