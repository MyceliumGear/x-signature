require 'spec_helper'

describe XSignature::NonceValidator do

  it "is just an abstract class" do
    expect { described_class.new.valid?(nil) }.to raise_error(NotImplementedError)
  end
end
