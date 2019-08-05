ENV['RAILS_ENV'] ||= 'test'

require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'database_cleaner'
require 'support/chromedriver'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view
  config.include Devise::Test::IntegrationHelpers, type: :feature
  config.include Devise::Test::IntegrationHelpers, type: :system
  config.include Warden::Test::Helpers

  config.infer_spec_type_from_file_location!
  config.include FactoryBot::Syntax::Methods
  config.use_transactional_fixtures = false
  
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end
  
  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end
  
  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end
  
  config.before(:each) do
    DatabaseCleaner.start
  end
  
  config.after(:each) do
    DatabaseCleaner.clean
  end
  
  config.before(:all) do
    DatabaseCleaner.start
  end
  
  config.after(:all) do
    DatabaseCleaner.clean
  end

  config.before(:each, type: :system) do
		driven_by(:rack_test)
	end
	
	config.before(:each, type: :system, js: true) do
		driven_by(:selenium_chrome_headless)
  end
  
  config.before(:all) do
    Capybara::Screenshot::Pruner.new(:keep_last_run).prune_old_screenshots
  end
end
