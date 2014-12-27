module Currentuser
  module Services
    module Authenticates
      def require_currentuser
        return  if currentuser_id
        redirect_to currentuser_sign_in_url
      end

      def currentuser_session
        return session[:currentuser]
      end

      def currentuser_id
        return @currentuser_id ||= currentuser_session && currentuser_session[:id]
      end

      def currentuser_sign_in_url
        return Services.currentuser_url(:sign_in)
      end

      def currentuser_sign_up_url
        return Services.currentuser_url(:sign_up)
      end

      def currentuser_sign_out_url
        return currentuser_services.sign_out_url
      end
    end

    def self.check_authentication_params!(params)
      raise unless params[:currentuser_id] && params[:timestamp] && params[:signature]

      # Check timestamp
      unless timestamp_recent?(params[:timestamp].to_i)
        raise TimestampTooOld, 'Timestamp is more than 10 minutes old'
      end

      # Check signature
      auth_string = [params[:currentuser_id], params[:timestamp]].join
      unless signature_authentic?(params[:signature], auth_string)
        raise SignatureNotAuthentic, 'Signature verification failed'
      end
    end

    def self.currentuser_url(action)
      return currentuser_url_for_project_id(configuration.project_id, action)
    end

    def self.currentuser_url_for_project_id(project_id, action)
      host = configuration.currentuser_services_host
      raise 'project_id should be set'  unless project_id
      raise 'action should be :sign_up or :sign_in'  unless action.in?([:sign_up, :sign_in])
      return "#{host}/#{project_id}/#{action}"
    end

    Error = Class.new(StandardError)
    TimestampTooOld = Class.new(Error)
    SignatureNotAuthentic = Class.new(Error)

    def self.timestamp_recent?(timestamp)
      return (Time.now - Time.at(timestamp)).abs < 10 * 60
    end

    def self.signature_authentic?(signature, auth_string)
      public_key = Services.configuration.currentuser_services_public_key
      return EncryptoSigno.verify(public_key, signature, auth_string)
    end
  end
end
