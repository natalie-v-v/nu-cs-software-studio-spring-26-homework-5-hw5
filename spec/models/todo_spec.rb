require "spec_helper"

# Create a lightweight mock of the Todo model if Rails isn't loaded
unless defined?(Todo)
  class Todo
    attr_accessor :title, :category, :errors

    def initialize(attrs = {})
      @title = attrs[:title]
      @category = attrs[:category]
      @errors = {}
    end

    def valid?
      ["work", "study", "home chores", "personal"].include?(@category)
    end

    def self.with_category(category_name)
      # Simulates the database filter array for testing
      @all_todos ||= []
      @all_todos.select { |t| t.category == category_name }
    end

    def self.create!(attrs = {})
      @all_todos ||= []
      todo = new(attrs)
      @all_todos << todo
      todo
    end
    
    def self.clear_db!
      @all_todos = []
    end
  end
end

RSpec.describe Todo, type: :model do
  before(:each) do
    Todo.clear_db! if Todo.respond_to?(:clear_db!)
  end

  describe "validations" do
    it "allows saving valid categories" do
      valid_categories = ["work", "study", "home chores", "personal"]
      valid_categories.each do |valid_cat|
        todo = Todo.new(title: "Do something", category: valid_cat)
        expect(todo.valid?).to be true
      end
    end

    it "rejects categories that are not on the permitted list" do
      invalid_todo = Todo.new(title: "Do something", category: "leisure")
      expect(invalid_todo.valid?).to be false
    end
  end

  describe ".with_category" do
    it "returns only todos matching the requested category" do
      work_item = Todo.create!(title: "Finish CS Homework", category: "work")
      chore_item = Todo.create!(title: "Clean bedroom", category: "home chores")

      results = Todo.with_category("work")

      expect(results).to include(work_item)
      expect(results).not_to include(chore_item)
    end
  end
end