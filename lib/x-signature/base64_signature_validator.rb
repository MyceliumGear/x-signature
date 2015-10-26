require 'openssl'
require 'base64'

module XSignature
  class Base64SignatureValidator < SignatureValidator

    def self.signature(secret:, nonce:, body:, method:, request_uri:)
      sha512    = OpenSSL::Digest::SHA512.new
      request   = "#{method.to_s.upcase}#{request_uri}#{sha512.digest("#{nonce}#{body}")}"
      signature = OpenSSL::HMAC.digest(sha512, secret.to_s, request)
      Base64.strict_encode64(signature)
    end
  end
end
