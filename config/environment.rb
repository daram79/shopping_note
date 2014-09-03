# Load the Rails application.
require File.expand_path('../application', __FILE__)

CONFIG = (YAML.load_file("#{::Rails.root.to_s}/config/config.yml")[::Rails.env] rescue {})

# Initialize the Rails application.
Rails.application.initialize!
