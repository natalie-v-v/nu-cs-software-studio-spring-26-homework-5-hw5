require "simplecov"
SimpleCov.start "rails" do
  minimum_coverage 80
  add_filter "/spec/"
  add_filter "/features/"
end