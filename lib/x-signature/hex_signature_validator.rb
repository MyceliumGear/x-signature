require 'openssl'

module XSignature
  class HexSignatureValidator < SignatureValidator

    def self.signature(secret:, nonce:, body:, method:, request_uri:)
      sha512  = OpenSSL::Digest::SHA512.new
      request = "#{method.to_s.upcase}#{request_uri}#{sha512.hexdigest("#{nonce}#{body}")}"
      OpenSSL::HMAC.hexdigest(sha512, secret.to_s, request)
    end
  end
end
