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
        signature:   env['HTTP_X_SIGNATURE'],
        client:      env['HTTP_X_CLIENT'],
        nonce:       env['HTTP_X_NONCE'],
        method:      request.method,
        request_uri: request_uri,
        body:        body,
      }
      super params
    end
  end
end
