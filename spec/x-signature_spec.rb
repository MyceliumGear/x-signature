require 'spec_helper'

describe XSignature do

  it 'has default configuration' do
    expect(XSignature.signature_header).to eq 'HTTP_X_SIGNATURE'
    expect(XSignature.client_header).to eq 'HTTP_X_CLIENT'
    expect(XSignature.nonce_header).to eq 'HTTP_X_NONCE'
  end

  it 'can be configured' do
    XSignature.configure do |config|
      config.signature_header = 's'
      config.client_header    = 'c'
      config.nonce_header     = 'n'
    end
    expect(XSignature.signature_header).to eq 's'
    expect(XSignature.client_header).to eq 'c'
    expect(XSignature.nonce_header).to eq 'n'
    XSignature.signature_header = 'HTTP_X_SIGNATURE'
    XSignature.client_header    = 'HTTP_X_CLIENT'
    XSignature.nonce_header     = 'HTTP_X_NONCE'
    expect(XSignature.signature_header).to eq 'HTTP_X_SIGNATURE'
    expect(XSignature.client_header).to eq 'HTTP_X_CLIENT'
    expect(XSignature.nonce_header).to eq 'HTTP_X_NONCE'
  end
end
