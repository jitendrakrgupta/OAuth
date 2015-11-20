require 'net/http'
require 'rest-client'
require 'json'

# OAuth Class to request and acquire a token
module OAuth
  class Token

    def initialize(tenant_id, subscription_id, client_id, client_secret,
                   grant_type='client_credentials', resource='https://management.azure.com/', api_version='2015-05-04-preview', log_level=0)
      # This initializes the credentials needed to acquire a token with some default parameters
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
          token_expiry: NIL,
          log_level: 0

      }
    end

    # This method sends a POST request to acquire an OAuth token
    # required parameters are :-
    # URL = Access token URL
    # client_id,client_secret,grant_type,resource
    def get_token
      begin
        @response = RestClient.post(
            @consumer[:token_request_url],
            client_id: @consumer[:client_id],
            client_secret: @consumer[:client_secret],
            grant_type: @consumer[:grant_type],
            resource: @consumer[:resource]
        )

        @consumer[:token] = 'Bearer ' + JSON.parse(@response)['access_token']
        @consumer[:token_expiry] = JSON.parse(@response)['expires_on']
      rescue => error
        puts("ERROR - Token Request Failed - #{error}")
      end
      @consumer[:token]
    end

    #TODO
    def validate_token(token, token_expiry)
    end

  end
end