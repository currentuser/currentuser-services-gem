module Currentuser
  module Services
    class SessionsController < ActionController::Base

      def sign_in
        Services.check_authentication_params!(params)

        # Log in
        session[:currentuser_id] = params[:currentuser_id]

        redirect_to '/'
      end

      def sign_out
        session.delete(:currentuser_id)

        redirect_to '/'
      end
    end
  end

end
