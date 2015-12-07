ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# include Capybara
require 'rails/test_help'
require 'capybara/rails'
puts 'I get to this point'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

Dir[Rails.root.join("test/helpers/**/*.rb")].each { |f| require f }


Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.always_include_port = true
Capybara.server_port = 4321
Capybara.raise_server_errors = false

class ActionController::TestCase
  # Helpful if using Devise for user auth
  # include Devise::TestHelpers
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  puts 'and to this point'
  include Capybara::DSL
  include Capybara::Angular::DSL

  def setup
    super
  end

  def teardown
    super
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end

# Ensure that node server is running ionic app
unless `lsof -i :5000`.include?('node')
  puts 'Starting ionic node server'
  Dir.chdir("../mobile") do
    system "PORT=5000 nohup node server.js > /dev/null 2>&1 &"
  end
end

# Force capybara to share db connections between threads.
class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || retrieve_connection
  end
end
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection

puts 'And here???'