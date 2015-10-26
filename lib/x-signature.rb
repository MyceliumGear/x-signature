require 'x-signature/version'

module XSignature

  Data = Struct.new(:secret, :signature, :client, :nonce, :method, :request_uri, :body)

  XSignatureError  = Class.new(StandardError)
  InvalidNonce     = Class.new(XSignatureError)
  InvalidSignature = Class.new(XSignatureError)

  autoload :RequestValidator, File.expand_path('../x-signature/request_validator', __FILE__)
  autoload :RailsRequestValidator, File.expand_path('../x-signature/rails_request_validator', __FILE__)

  autoload :NonceValidator, File.expand_path('../x-signature/nonce_validator', __FILE__)
  autoload :RedisNonceValidator, File.expand_path('../x-signature/redis_nonce_validator', __FILE__)

  autoload :SignatureValidator, File.expand_path('../x-signature/signature_validator', __FILE__)
  autoload :SignatureMultiValidator, File.expand_path('../x-signature/signature_multi_validator', __FILE__)
  autoload :Base64SignatureValidator, File.expand_path('../x-signature/base64_signature_validator', __FILE__)
  autoload :HexSignatureValidator, File.expand_path('../x-signature/hex_signature_validator', __FILE__)

end
