require 'helper'

# Apparently we need to require the routes. Not sure why.
require_relative '../../../config/routes'

# Load test application
require 'rails/generators' # Not sure why we need that
require 'test_application/application'

require 'minitest/rails/capybara'
require 'capybara/mechanize'

require 'currentuser/data'
require 'currentuser/data/test/helpers'

#Rails.logger = Logger.new(STDOUT)
Rails.logger = Logger.new('/dev/null')

Currentuser::Data::BaseResource.site = ENV['CURRENTUSER_DATA_URL']
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

        visit '/'
        assert_equal '/', current_path
        assert has_text? 'Public page'
      end

      test 'sign in and sign out' do
        Currentuser::Data::User.create(email: 'email@example.org', password: 'password')
        visit '/inside'
        assert_match /sign_in/, current_path

        fill_in 'Email', with: 'email@example.org'
        fill_in 'Password', with: 'password'
        click_button 'Sign In'

        visit '/inside'
        assert_equal '/inside', current_path
        assert has_text? 'Private page'

        visit 'currentuser/sign_out'
        assert_equal '/', current_path

        visit '/inside'
        assert_match /sign_in/, current_path
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

      test 'available' do
        visit '/currentuser'

        assert_equal 200, page.status_code
      end
    end
  end
end
