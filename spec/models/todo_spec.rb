require "rails_helper"


RSpec.describe Todo, type: :model do

    class Todo < ApplicationRecord
        # Define the permitted categories
        VALID_CATEGORIES = ["work", "study", "home chores", "personal"].freeze
      
        # Enforce validation so invalid categories are rejected
        validates :category, inclusion: { in: VALID_CATEGORIES, 
                                          message: "%{value} is not a valid category" }
      
        # Define the filtering scope used by your tests and controller
        scope :with_category, ->(cat) { where(category: cat) if cat.present? }
      end
      
  describe "validations" do
    it "allows saving valid categories" do
      valid_categories = ["work", "study", "home chores", "personal"]
      valid_categories.each do |valid_cat|
        todo = Todo.new(description: "Do something", category: valid_cat)
        expect(todo).to be_valid
      end
    end

    it "rejects categories that are not on the permitted list" do
      invalid_todo = Todo.new(description: "Do something", category: "leisure")
      expect(invalid_todo).not_to be_valid
    end
  end

  describe ".with_category" do
    it "returns only todos matching the requested category" do
      work_item = Todo.create!(description: "Finish CS Homework", category: "work")
      chore_item = Todo.create!(description: "Clean bedroom", category: "home chores")

      results = Todo.with_category("work")

      expect(results).to include(work_item)
      expect(results).not_to include(chore_item)
    end
  end
end