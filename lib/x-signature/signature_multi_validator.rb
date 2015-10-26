module XSignature
  class SignatureMultiValidator

    attr_accessor :validators

    def initialize(*validators)
      @validators = validators.flatten
    end

    def valid?(data)
      validators.any? { |validator| validator.valid?(data) }
    end
  end
end
