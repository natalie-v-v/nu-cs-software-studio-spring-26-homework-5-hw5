require "rails_helper"

RSpec.describe "Todos index filtering", type: :request do
  describe "GET /todos" do
    it "successfully filters and renders todos by the category parameter" do
      work_todo = Todo.create!(description: "Office meeting", category: "work")
      study_todo = Todo.create!(description: "Study for exam", category: "study")

      get todos_path, params: { category: "work" }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Office meeting")
      expect(response.body).not_to include("Study for exam")
    end
  end
end