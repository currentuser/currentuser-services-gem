require 'helper'

# Load test application
require 'rails'
require 'rails/generators' # Not sure why we need that
require 'test_application/application'

require 'minitest/rails/capybara'
require 'capybara/mechanize'

require 'currentuser/data'
require 'currentuser/data/test/helpers'

Rails.logger = Logger.new('/dev/null')

Currentuser::Data::Test::UseReadApi.currentuser_application_id_for_tests =
    Currentuser::Services.configuration.application_id

module Currentuser
  module Services
    Capybara.current_driver = :mechanize
    class IntegrationTest < ActionDispatch::IntegrationTest
      include Capybara::DSL
      include Currentuser::Data::Test::UseWriteApi

      teardown do
        Capybara.reset_sessions!    # Forget the (simulated) browser state
      end

      test 'one can visit public page' do

        visit '/outside'
        assert_equal '/outside', current_path
        assert has_text? 'Public page'
      end

      test 'sign in' do
        Currentuser::Data::User.create(email: 'email@example.org', password: 'password')
        visit '/inside'
        assert_match /sign_in/, current_path

        fill_in 'Email', with: 'email@example.org'
        fill_in 'Password', with: 'password'
        click_button 'Sign In'

        visit '/inside'
        assert_equal '/inside', current_path
        assert has_text? 'Private page'
      end

      test 'sign up' do
        visit Services.currentuser_url(:sign_up)

        fill_in 'Email', with: 'email@example.org'
        fill_in 'Password', with: 'password'
        click_button 'Sign Up'
        assert_equal '/', current_path
        assert has_text? 'Public page'

        # Check user is connected
        visit '/inside'
        assert has_text? 'Private page'
      end
    end
  end
end
