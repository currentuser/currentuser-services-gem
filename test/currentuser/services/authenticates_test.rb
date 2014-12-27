require 'helper'

module Currentuser
  module Services

    class TestAuthenticatesController <  ActionController::Base
      before_action :require_currentuser

      def test_action_requiring_user
        head :ok
      end
    end

    class AuthenticatesTest < ActionController::TestCase
      tests TestAuthenticatesController

      def get_with_route(action)
        with_routing do |map|
          map.draw do
            namespace :currentuser do
              namespace :services do
                get '/any_path', to: 'test_authenticates#test_action_requiring_user'
              end
            end
          end
          get action
        end
      end

      # require_currentuser

      test 'execute action if currentuser_id is available' do
        session[:currentuser] = {id: 'user_id_1'}

        get_with_route :test_action_requiring_user
        assert_response :ok
      end

      test 'redirects to sign_in URL if currentuser_id is not available' do
        assert_nil session[:currentuser]

        get_with_route :test_action_requiring_user
        assert_response :redirect
        assert_redirected_to Services.currentuser_url(:sign_in)
      end

      # currentuser_session

      test 'currentuser_session returns currentuser session' do
        session[:currentuser] = {foo: 'blah'}

        assert_equal({foo: 'blah'}, @controller.currentuser_session)
      end

      # currentuser_id

      test 'currentuser_id returns currentuser ID' do
        session[:currentuser] = {id: 'user_id_1'}

        assert_equal 'user_id_1', @controller.currentuser_id
      end

      test 'currentuser_id returns nil if no current user session' do
        refute session.key?(:currentuser)
        assert_nil @controller.currentuser_id
      end

      # sign_in_url

      test 'sign_in_url returns the expected url' do
        assert_equal "http://localhost:3001/#{Services.configuration.project_id}/sign_in", @controller.currentuser_sign_in_url
      end

      # sign_up_url

      test 'sign_up_url returns the expected url' do
        assert_equal "http://localhost:3001/#{Services.configuration.project_id}/sign_up", @controller.currentuser_sign_up_url
      end
    end
  end
end
