module Currentuser
  module Services
    class SessionsController < ActionController::Base

      def sign_in
        Services.check_authentication_params!(params)

        # Log in
        session[:currentuser] = {id: params[:currentuser_id]}
        # Note that params[:sign_up] should equal 'true' (String) or should be absent.
        session[:currentuser][:sign_up] = true  if params[:sign_up]

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
