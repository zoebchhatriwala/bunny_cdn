lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "helpers/version"

Gem::Specification.new do |spec|
  spec.name = "bunny_cdn"
  spec.version = BunnyCDN::VERSION
  spec.date = "2020-09-10"
  spec.summary = "BunnyCDN Gem helps you connect with BunnyCDN API"
  spec.description = "BunnyCDN Gem helps you connect with BunnyCDN API"
  spec.authors = ["Brandon Meeks (https://github.com/brandon-meeks/bunny_cdn)", "Zoeb Chhatriwala"]
  spec.email = "zoeb@chhatriwala.com"
  spec.files = ["lib/bunnycdn.rb"]
  spec.homepage = "https://chhatriwala.com/"
  spec.license = "MIT"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/zoebchhatriwala/bunny_cdn"
  spec.metadata["changelog_uri"] = "https://github.com/zoebchhatriwala/bunny_cdn/releases"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rest-client", "~> 2.1"
  spec.add_dependency "json", "~> 2.3"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 3.8", ">= 3.8.3"

  spec.required_ruby_version = ">= 2.0.1"
end
