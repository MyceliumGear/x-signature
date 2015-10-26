require 'spec_helper'

describe XSignature::Base64SignatureValidator do

  it "creates base64 encoded signatures" do
    expect(described_class.signature(secret: nil, nonce: nil, body: nil, method: nil, request_uri: nil)).to eq '6Iv+1ATLEFHY0AjudIxiRus+viNpXGj+rm9lBgXoTNQRKrf8bPOD/mgcIoUH/A4rrOBr8WTYw/Wy2lra8LfwLg=='
    expect(described_class.signature(secret: '', nonce: '', body: '', method: '', request_uri: '')).to eq '6Iv+1ATLEFHY0AjudIxiRus+viNpXGj+rm9lBgXoTNQRKrf8bPOD/mgcIoUH/A4rrOBr8WTYw/Wy2lra8LfwLg=='
    expect(described_class.signature(secret: '42', nonce: nil, body: nil, method: nil, request_uri: nil)).to eq 'uXISW3oKhtHy/sBS1c1DfcQQbqCj4bFeXlu+LuoRaPZQuIu/FbYFFK311Q2shLf2UJWMJrD+BReFMPNwd9CTog=='
    expect(described_class.signature(secret: '42', nonce: 1, body: nil, method: nil, request_uri: nil)).to eq 'vpkM9Y0W4AC2YlT3tqdfPr9fd468/Yhlj1A2kI4x0QVuYsfaKzaBTVcIw+vNxObB6+zcnwvf2B7nlRegMLSjWg=='
    expect(described_class.signature(secret: '42', nonce: 1, body: 'test', method: nil, request_uri: nil)).to eq 'vgtls2e0C0pnTlQDebf5+RlLs4MeQdWe1pyzAVUrqTHO62Gf58pTmbrLlNC/gD5pMjLHZHMn3HZzTUUrtukkYA=='
    expect(described_class.signature(secret: '42', nonce: 1, body: 'test', method: 'get', request_uri: nil)).to eq 'LSTynmhlTHEmV2iuFfNbpSpdsAZnaDhsapNMwGZsy3gugFeN4tmR4nllar6IlKhB5XtEKjBmZGlFpLsv4ctQnA=='
    expect(described_class.signature(secret: '42', nonce: 1, body: 'test', method: 'GET', request_uri: nil)).to eq 'LSTynmhlTHEmV2iuFfNbpSpdsAZnaDhsapNMwGZsy3gugFeN4tmR4nllar6IlKhB5XtEKjBmZGlFpLsv4ctQnA=='
    expect(described_class.signature(secret: '42', nonce: 1, body: 'test', method: 'GET', request_uri: '/path')).to eq '39p3Z9+Wbfkm43HNX0YWwYrvfp3YiI6QaCDp3rB/Id0YatUNzjriMwoDoiDAU6vzHREjhJji71KQvbuGN/eqfA=='
  end
end
