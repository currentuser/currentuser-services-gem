module Currentuser
  module Services
    module Authenticates
      Error = Class.new(StandardError)
      TimestampTooOld = Class.new(Error)
      SignatureNotAuthentic = Class.new(Error)

      def try_sign_in
        return unless params[:currentuser_id] && params[:timestamp] && params[:signature]

        # Check timestamp
        unless Services.timestamp_recent?(params[:timestamp].to_i)
          raise TimestampTooOld, 'Timestamp is more than 10 minutes old'
        end

        # Check signature
        auth_string = [params[:currentuser_id], params[:timestamp]].join
        unless Services.signature_authentic?(params[:signature], auth_string)
          raise SignatureNotAuthentic, 'Signature verification failed'
        end

        # Log in
        session[:currentuser_id] =  params[:currentuser_id]
        @currentuser_id =  params[:currentuser_id]
      end

      def require_currentuser
        return  if currentuser_id
        redirect_to sign_in_url
      end

      def currentuser_id
        return @currentuser_id ||= session[:currentuser_id]
      end

      def sign_out
        @currentuser_id = nil
        session.delete(:currentuser_id)
      end

      def sign_in_url
        return Services.currentuser_url(:sign_in)
      end

      def sign_up_url
        return Services.currentuser_url(:sign_up)
      end
    end

    def self.currentuser_url(action)
      host = configuration.currentuser_services_host
      application_id = configuration.application_id
      return "#{host}/#{application_id}/#{action}"
    end

    # Define separate method to make stubbing easier.
    def self.timestamp_recent?(timestamp)
      return (Time.now - Time.at(timestamp)).abs < 10 * 60
    end

    # Define separate method to make stubbing easier.
    def self.signature_authentic?(signature, auth_string)
      public_key = Services.configuration.currentuser_services_public_key
      return EncryptoSigno.verify(public_key, signature, auth_string)
    end
  end
end
