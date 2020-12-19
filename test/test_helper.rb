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

  # Log in as a particular user.
  def log_in_as(user)
    session[:user_id] = user.id
  end
end


class ActionDispatch::IntegrationTest
  # Log in as a particular user.
  # Because it’s located inside the ActionDispatch::IntegrationTest class, 
  # this is the version of log_in_as that will be called 
  # inside integration tests. We use the same method name 
  # in both cases because it lets us do things like use code 
  # from a controller test in an integration test without making any changes to the login method
  def log_in_as(user, password: 'password', remember_me: '1')
    post login_path, params: { session: { email: user.email,
                                          ​password: password,
                                          ​remember_me: remember_me } }
  end
end
