module Currentuser
  module Services
    class SessionsController < ActionController::Base

      def sign_in
        Services.check_authentication_params!(params)

        # Note: in this method, we create an hash with string keys because, with Rails 4.2.0, keys are stringified
        # between two requests if session is stored in a json cookie (which is the default behavior for Rails 4.2.0).
        hash = {}

        # Log in
        hash['id'] = params[:currentuser_id]
        # Note that params[:sign_up] should equal 'true' (String) or should be absent.
        hash['sign_up'] = true  if params[:sign_up]

        session[:currentuser] = hash

        redirect_to '/'
      end

      def sign_out
        session.delete(:currentuser)

        redirect_to '/'
      end

      def available
        head :ok
      end
    end
  end

end
