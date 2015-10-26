require 'spec_helper'

describe XSignature::SignatureMultiValidator do

  it "delegates validation to the arbitrary validators list" do
    @validators = [double('validator 1'), double('validator 2'), double('validator 3')]
    expect(@validators[0]).to receive(:valid?).and_return(false)
    expect(@validators[1]).to receive(:valid?).and_return(true)
    @instance = described_class.new(@validators)
    expect(@instance.valid?(nil)).to eq true
  end

  it "is always invalid if the validators list is empty" do
    @instance = described_class.new
    expect(@instance.valid?(nil)).to eq false
  end
end
