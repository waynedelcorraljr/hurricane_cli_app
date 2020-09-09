require_relative 'lib/hurricane_cli_app/version'

Gem::Specification.new do |spec|
  spec.name          = "hurricane_cli_app"
  spec.version       = HurricaneCliApp::VERSION
  spec.authors       = ["Wayne del Corral Jr"]
  spec.email         = ["wdelcorjr@gmail.com"]

  spec.summary       = %q{'basic Hurricane tracker CLI app'}
  spec.homepage      = "https://github.com/wdelcorjr/hurricane_cli_app"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/wdelcorjr/hurricane_cli_app"
  spec.metadata["changelog_uri"] = "https://github.com/wdelcorjr/hurricane_cli_app/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
