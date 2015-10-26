require 'spec_helper'

describe XSignature::RequestValidator do

  it "can be initialized with the default params" do
    @instance = described_class.new
    expect(@instance.signature_validator.class).to eq XSignature::SignatureMultiValidator
    expect(@instance.signature_validator.validators.map(&:class)).to eq [XSignature::HexSignatureValidator, XSignature::Base64SignatureValidator]
    expect(@instance.nonce_validator.class).to eq XSignature::RedisNonceValidator
  end

  it "can be initialized with the custom params" do
    @instance = described_class.new(signature_validator: 1, nonce_validator: 2)
    expect(@instance.signature_validator).to eq 1
    expect(@instance.nonce_validator).to eq 2
  end

  it "raises an error if the nonce is invalid" do
    @nonce_validator     = double('nonce_validator')
    @signature_validator = double('signature_validator')
    expect(@nonce_validator).to receive(:valid?).exactly(2).times.and_return(false)
    expect(@signature_validator).not_to receive(:valid?)
    @instance = described_class.new(nonce_validator: @nonce_validator, signature_validator: @signature_validator)
    expect { @instance.validate({}) }.to raise_error(XSignature::InvalidNonce)
    expect(@instance.valid?({})).to eq false
  end

  it "raises an error if the signature is invalid" do
    @nonce_validator     = double('nonce_validator')
    @signature_validator = double('signature_validator')
    expect(@nonce_validator).to receive(:valid?).exactly(2).times.and_return(true)
    expect(@signature_validator).to receive(:valid?).exactly(2).times.and_return(false)
    @instance = described_class.new(nonce_validator: @nonce_validator, signature_validator: @signature_validator)
    expect { @instance.validate({}) }.to raise_error(XSignature::InvalidSignature)
    expect(@instance.valid?({})).to eq false
  end

  it "returns true if the nonce and the signature are valid" do
    @data                 = {secret: 1, signature: 2, client: 3, nonce: 4, method: 5, request_uri: 6, body: 7}
    @data_struct          = XSignature::Data.new(*1..7)
    @nonce_validator     = double('nonce_validator')
    @signature_validator = double('signature_validator')
    expect(@nonce_validator).to receive(:valid?).with(@data_struct).exactly(2).times.and_return(true)
    expect(@signature_validator).to receive(:valid?).with(@data_struct).exactly(2).times.and_return(true)
    @instance = described_class.new(nonce_validator: @nonce_validator, signature_validator: @signature_validator)
    expect(@instance.validate(@data)).to eq true
    expect(@instance.valid?(@data)).to eq true
  end

  it "raises an error if the data has unknown key" do
    @data      = {seсret: 1} # cyrillic 'с' :)
    @instance = described_class.new
    expect { @instance.validate(@data) }.to raise_error(NameError)
    expect { @instance.valid?(@data) }.to raise_error(NameError)
  end
end
