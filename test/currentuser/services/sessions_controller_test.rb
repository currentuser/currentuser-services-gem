require 'helper'

module Currentuser
  module Services

    class SessionsControllerTest < ActionController::TestCase
      tests SessionsController

      def process_with_route(verb, action, params, session={})
        with_routing do |map|
          map.draw do
            currentuser
          end
          send verb, action, params.merge(use_route: 'currentuser/services'), session
        end
      end

      def get_with_route(action, params={})
        process_with_route :get, action, params
      end

      def delete_with_route(action, params, session)
        process_with_route :delete, action, params, session
      end

      # sign_in

      test 'sign_in logs user in and redirects to root' do

        # Take a recent timestamp
        timestamp = (Time.now - 60).to_i.to_s
        user_id = 'user_id_1'

        # By pass signature checking
        Services.stub :signature_authentic?, true do
          get_with_route :sign_in, currentuser_id: user_id, timestamp: timestamp, signature: 'any_signature'
        end

        assert_redirected_to '/'
        assert_equal({id: user_id}, session[:currentuser])
        refute session[:currentuser].has_key?(:sign_up)
      end

      test 'sign_in sets sign_up if sign_up is true' do

        # Take a recent timestamp
        timestamp = (Time.now - 60).to_i.to_s

        # By pass signature checking
        Services.stub :signature_authentic?, true do
          get_with_route :sign_in, currentuser_id: 'user_id_1', timestamp: timestamp, signature: 'any_signature',
                         sign_up: 'true'
        end

        assert_redirected_to '/'
        assert_equal true, session[:currentuser][:sign_up]
      end

      # This test proves that we use Services#check_authentication_params!
      test 'sign_in raises SignatureNotAuthentic if signature is wrong' do
         # Take a recent timestamp
        timestamp = (Time.now - 60).to_i.to_s

        assert_raises SignatureNotAuthentic do
          get_with_route :sign_in, currentuser_id: 'user_id_1', timestamp: timestamp, signature: 'any_signature'
        end
      end

      # sign_out

      test 'sign_out deletes session and redirects to root' do
        session_hash = {currentuser: {foo: :blah}, other_key: :other_value}

        delete_with_route :sign_out, {}, session_hash
        assert_redirected_to '/'

        assert_nil session[:currentuser]
        assert_equal :other_value, session[:other_key]
      end

      # available

      test 'GET available return 300' do
        get_with_route 'available'
        assert_response :ok
      end

    end
  end
end
