# Load local environment variables before Bundler and Rails initialize.
# .env is intentionally ignored by Git; only .env.example is committed.
env_file = File.expand_path("../.env", __dir__)

if File.file?(env_file)
  File.foreach(env_file) do |line|
    line = line.strip
    next if line.empty? || line.start_with?("#")

    key, value = line.split("=", 2)
    next unless key&.match?(/\A[A-Za-z_][A-Za-z0-9_]*\z/) && value

    value = value.strip
    if (value.start_with?('"') && value.end_with?('"')) ||
       (value.start_with?("'") && value.end_with?("'"))
      value = value[1...-1]
    end

    ENV[key] ||= value
  end
end

ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup" # Set up gems listed in the Gemfile.
require "bootsnap/setup" # Speed up boot time by caching expensive operations.
