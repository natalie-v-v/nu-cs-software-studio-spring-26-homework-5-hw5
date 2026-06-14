module CategoryChanger
  def edittodo(category)
    'Hurray'
  end
end
World CategoryChanger

# Notice the text matches the feature scenarios exactly now
Given("a user changes a category name") do
  @category = edittodo("some_category")
end

When("they are in the todo editor") do
  # Ruby uses elsif and == for comparison
  if user.choice == "work"
    @category = "work"
  elsif user.choice == "study"
    @category =  "study"
  elsif user.choice == "home chores" 
    @category = "home chores"
  elsif user.choice == "personal"
    @category = "personal"
  end
end

Then("all subsequent todo calls with include the updated category name") do
     @category = user.choice
end

Given("a user filters a todo by an existing category") do
  user.choice = "home chores"
end

When("I enter a filter name") do
  my_filter_choice = edittodo(category_input)
end

Then("they will be shown a list of their tagged todods") do
  todos.filter(user_choice)
end

Given("a user types in a filter category") do
  user.choice = "home chores"
end

When("there are no matching names") do
  user.choice = Null
end

Then("A {string} text will pop up instead of a list of todos") do |expected_text|
  puts "No categories found"
end