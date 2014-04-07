require "rspec/expectations"
require 'require_all'
require_all 'lib'

RSpec.configure do |config|
  config.after(:each) do
    CaveGenerator.reset_behavior_to_normal
  end
end