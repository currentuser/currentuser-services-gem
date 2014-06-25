require 'helper'

module Currentuser
  module Services

    class TestAuthenticatesController <  ActionController::Base
      before_action :require_currentuser, only: :test_action_requiring_user

      def test_action
        head :ok
      end

      def test_action_requiring_user
        head :ok
      end
    end

    class AuthenticatesTest < ActionController::TestCase
      tests TestAuthenticatesController

      def get_with_route action, *params
        with_routing do |map|
          map.draw do
            namespace :currentuser do
              namespace :services do
                get '/any_path_1', to: 'test_authenticates#test_action'
                get '/any_path_2', to: 'test_authenticates#test_action_requiring_user'
              end
            end
          end
          get action, *params
        end
      end

      # try_sign_in

      test 'test_action can be called' do
        get_with_route :test_action
        assert_response :ok
        assert_nil session[:currentuser_id]
      end

      test 'can authenticate (stubbing :timestamp_recent?)' do
        assert_nil session[:currentuser_id]

        # These data have been prepare using current-services private key.
        timestamp = 100000
        user_id = 'user_id_1'
        signature = "RmYbwPNZc418905uSHHmrmkKcekj7OQw8zU372g6aEuMufOExuEJcSH3Zokq\nbJLFT89wxcF0/s9Ks2EV3cmuvoe5RQeanro7a0m+KpZskBt3IqxRiXFGr6sE\nvBfWrDQC24lJjKjIn76qMvwd/A6PmN0uyQz/QtE1FjXdNauYPq9xJoSPdL+T\nr3Y8uCnBkT8E1AwuiMC9zIjQVEBukmbR9LW8QNvg3+vdJfoxIsf4Gxxs5V6e\n0r7fk5Vz5uws3D/DmUWnfRaPaW9KYVB5VoOAD/P2TlGNZ7wurlYXuHPfK0QX\njkThXYrpFn6m5u2rVyFoNanroDTqIcndKxLDeXE0sg==\n"

        # As we use a fixed timestamp we have to simulate it is recent
        Services.stub :timestamp_recent?, true do
          get_with_route :test_action, currentuser_id: user_id, timestamp: timestamp, signature: signature
        end

        assert_response :ok
        assert_equal user_id, session[:currentuser_id]
      end

      test 'can authenticate (stubbing :signature_authentic?)' do
        assert_nil session[:currentuser_id]

        # Take a recent timestamp
        timestamp = (Time.now - 60).to_i.to_s
        user_id = 'user_id_1'
        signature = 'any_signature'

        # By pass signature checking
        Services.stub :signature_authentic?, true do
          get_with_route :test_action, currentuser_id: user_id, timestamp: timestamp, signature: signature
        end

        assert_response :ok
        assert_equal user_id, session[:currentuser_id]
      end

      test 'raises if timestamp too old' do
        assert_nil session[:currentuser_id]

        # Take an old timestamp (and an invalid signature, but this has no impact)
        timestamp = (Time.now - 15 * 60).to_i.to_s
        user_id = 'user_id_1'
        signature = 'any_signature'

        assert_raises Authenticates::TimestampTooOld do
          get_with_route :test_action, currentuser_id: user_id, timestamp: timestamp, signature: signature
        end

        assert_nil session[:currentuser_id]
      end

      test 'raises if signature invalid' do
        assert_nil session[:currentuser_id]

        # Take a recent timestamp and an invalid signature
        timestamp = (Time.now - 60).to_i.to_s
        user_id = 'user_id_1'
        signature = 'any_signature'

        assert_raises Authenticates::SignatureNotAuthentic do
          get_with_route :test_action, currentuser_id: user_id, timestamp: timestamp, signature: signature
        end

        assert_nil session[:currentuser_id]
      end

      # require_currentuser

      test 'execute action if currentuser_id is available' do
        session[:currentuser_id] = 'user_id_1'

        get_with_route :test_action_requiring_user
        assert_response :ok
      end

      test 'redirects to sign_in URL if currentuser_id is not available' do
        assert_nil session[:currentuser_id]

        get_with_route :test_action_requiring_user
        assert_response :redirect
        assert_redirected_to Services.currentuser_url(:sign_in)
      end

      # currentuser_id

      test 'currentuser_id returns currentuser ID' do
        session[:currentuser_id] = 'user_id_1'

        assert_equal 'user_id_1', @controller.currentuser_id
      end

      # sign_out

      test 'sign_out signs out' do
        session[:currentuser_id] = 'user_id_1'
        @controller.sign_out
        assert_nil session[:currentuser_id]
      end

      # sign_in_url

      test 'sign_in_url returns the expected url' do
        assert_equal "http://localhost:3001/#{Services.configuration.application_id}/sign_in", @controller.sign_in_url
      end

      # sign_up_url

      test 'sign_up_url returns the expected url' do
        assert_equal "http://localhost:3001/#{Services.configuration.application_id}/sign_up", @controller.sign_up_url
      end
    end
  end
end
