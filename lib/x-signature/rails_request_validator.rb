require 'uri'

module XSignature
  class RailsRequestValidator < RequestValidator

    def validate(secret:, request:)
      env  = request.env
      body = request.body
      if body.kind_of?(StringIO)
        body = body.string
      end
      request_uri = (URI(env['REQUEST_URI']).request_uri rescue env['REQUEST_URI'])
      params      = {
        secret:      secret,
        signature:   env[XSignature.signature_header],
        client:      env[XSignature.client_header],
        nonce:       env[XSignature.nonce_header],
        method:      request.method,
        request_uri: request_uri,
        body:        body,
      }
      super params
    end
  end
end
