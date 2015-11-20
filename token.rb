require 'net/http'
require 'rest-client'
require 'json'

# OAuth Class to request and acquire a token

module OAuth
  class Token
    def initialize(tenant_id, subscription_id, client_id, client_secret,
                   grant_type='client_credentials', resource='https://management.azure.com/', api_version='2015-05-04-preview')
      @consumer = {
          tenant_id: tenant_id,
          subscription_id: subscription_id,
          client_id: client_id,
          client_secret: client_secret,
          grant_type: grant_type,
          resource: resource,
          api_version: api_version,
          token_request_url: "https://login.windows.net/#{tenant_id}/oauth2/token",
          token: NIL,
          token_expiry: NIL

      }
    end

    def get_token
      begin
        @response = RestClient.post(
            @consumer[:token_request_url],
            :client_id => @consumer[:client_id],
            :client_secret => @consumer[:client_secret],
            :grant_type => @consumer[:grant_type],
            :resource => @consumer[:resource]
        )

        @consumer[:token] = 'Bearer ' + JSON.parse(@response)['access_token']
        @consumer[:token_expiry] = JSON.parse(@response)['expires_on']
      rescue => e
        puts("Token Request Failed - #{e}")
      end
      return @consumer[:token]
    end

    def validate_token(token, token_expiry)
    end

  end
end