

Feature: Change Categories
  A user wants to assign a category to each todo and filter my list by category so they can focus on related tasks.

  Scenario: Require Categories
    Given a user filters a todo by an existing category
    When they are in the todo editor
    Then they will be shown a list of their tagged todods


  Scenario: Categories with no Matches
    Given a user types in a filter category 
    When there are no matching names 
    Then A "no category found" text will pop up instead of a list of todos

  Scenario: Edit todos
    Given a user changes a category name
    When they are in the todo editor 
    Then all subsequent todo calls with include the updated category name 

