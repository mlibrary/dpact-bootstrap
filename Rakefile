require "dotenv/tasks"
require "rubocop/rake_task"
require "rspec/core/rake_task"
require "cucumber/rake/task"

RuboCop::RakeTask.new(:rubocop)
RSpec::Core::RakeTask.new(:spec)
Cucumber::Rake::Task.new(:cucumber)

namespace :rubocop do
  RuboCop::RakeTask.new(:fix) do |t|
    t.options = ["--auto-correct-all"]
  end
end

task ci: %i[rubocop spec cucumber]
task default: :ci
