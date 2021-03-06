module XSignature
  class RequestValidator

    attr_accessor :signature_validator, :nonce_validator

    def initialize(signature_validator: nil, nonce_validator: nil, check_nonce: true)
      @signature_validator = signature_validator || SignatureMultiValidator.new(HexSignatureValidator.new, Base64SignatureValidator.new)
      @nonce_validator     = nonce_validator || RedisNonceValidator.new
      @check_nonce         = check_nonce
    end

    # :secret, :signature, :client, :nonce, :method, :request_uri, :body
    def validate(**args)
      data = Data.new
      args.each do |k, v|
        data[k] = v
      end
      fail InvalidNonce if @check_nonce && !@nonce_validator.valid?(data)
      fail InvalidSignature unless @signature_validator.valid?(data)
      true
    end

    def valid?(**args)
      validate(**args)
    rescue XSignatureError
      false
    end
  end
end
