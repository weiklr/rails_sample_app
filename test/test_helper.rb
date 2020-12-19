ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use!
class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  # create test-specific helper method to check login as helper methods are available in tests so can't use @current_user to check
  # we called this is_logged_in to differentiate from the actual method logged_in used in dev and production env
  def is_logged_in?
    !session[:user_id].nil?
  end
end
