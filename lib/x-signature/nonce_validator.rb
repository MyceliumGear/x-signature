module XSignature
  class NonceValidator

    # Some state should be maintained in order to protect API from replay attack
    # https://en.wikipedia.org/wiki/Cryptographic_nonce
    # @param [XSignature::Data] data
    def valid?(data)
      fail NotImplementedError
    end
  end
end
