module XSignature
  class SignatureValidator

    # @param [XSignature::Data] data
    def valid?(data)
      params = self.class.method(:signature).parameters.map(&:last).each_with_object({}) do |param, hash|
        hash[param] = data[param]
      end
      data.signature == self.class.signature(**params)
    end
  end
end
