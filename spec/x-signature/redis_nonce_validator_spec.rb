require 'spec_helper'

describe XSignature::RedisNonceValidator do

  it "can be initialized with the default params" do
    @validator = described_class.new
    expect(@validator.redis_connection.object_id).to eq Redis.current.object_id
    expect(@validator.keys_prefix).to eq 'XSignature:LastNonce:'
  end

  it "can be initialized with the custom params" do
    @validator = described_class.new(redis_connection: 1, keys_prefix: 2)
    expect(@validator.redis_connection).to eq 1
    expect(@validator.keys_prefix).to eq 2
  end

  it 'validates nonce' do
    @data = XSignature::Data.new
    @data.client = 0
    @data.nonce = 10
    @validator = described_class.new
    keys = @validator.redis_connection.keys("#{@validator.keys_prefix}*")
    @validator.redis_connection.del keys unless keys.empty?
    expect(@validator.valid?(@data)).to eq true
    expect(@validator.valid?(@data)).to eq false
    @data.nonce = 9
    expect(@validator.valid?(@data)).to eq false
    @data.nonce = 11
    expect(@validator.valid?(@data)).to eq true
    expect(@validator.valid?(@data)).to eq false
  end
end
