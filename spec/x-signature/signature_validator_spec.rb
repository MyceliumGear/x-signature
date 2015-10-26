require 'spec_helper'

describe XSignature::SignatureValidator do

  it "calls signature calculation method" do
    TestSignatureValidator = Class.new(described_class) do
      def self.signature(secret:)
        secret
      end
    end
    @data = XSignature::Data.new
    @data.signature = 'test'
    expect(TestSignatureValidator.new.valid?(@data)).to eq false
    @data.secret = 'test'
    expect(TestSignatureValidator.new.valid?(@data)).to eq true
  end
end
