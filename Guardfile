notification :terminal_notifier

guard :rspec do
  watch(/spec/)
  watch('Gemfile') { "spec" }
  watch(%r{^lib/(.+)\.rb$}) { "spec" }
end

