require 'spec_helper'

describe XSignature::HexSignatureValidator do

  it "creates base64 encoded signatures" do
    expect(described_class.signature(secret: nil, nonce: nil, body: nil, method: nil, request_uri: nil)).to eq '1027600a0144f439e9ee4f1d3b5642672082e7a957501d541eb6135f384bedc383fc6a5cc28422e43ec414a61ac9177771f62ef9d3690dda9a05faa028d5b184'
    expect(described_class.signature(secret: '', nonce: '', body: '', method: '', request_uri: '')).to eq '1027600a0144f439e9ee4f1d3b5642672082e7a957501d541eb6135f384bedc383fc6a5cc28422e43ec414a61ac9177771f62ef9d3690dda9a05faa028d5b184'
    expect(described_class.signature(secret: '42', nonce: nil, body: nil, method: nil, request_uri: nil)).to eq '4da79600c24259e49b332c28eaf81ffc7361daea2471df02443bfef1c84de559564ae797316456f245f7ae236514058dbfaab5c73286f32743a19dec41972bfe'
    expect(described_class.signature(secret: '42', nonce: 1, body: nil, method: nil, request_uri: nil)).to eq '34ea0c1dacbd6761ccbaff43a87bc209f58c3f7f84fcd0e8d289d20d317c0602cc0f4b2b4b510f809cd4b036ec281a8258c26af680d7891d42f6bdf2e8e67eba'
    expect(described_class.signature(secret: '42', nonce: 1, body: 'test', method: nil, request_uri: nil)).to eq 'df2ceb4ba00f0a498b131c13fe37f729aa8f4ac044d927ecf7e5c3ca82d0264b7f0f24ae82d8bc1a5c6126add5825e9fd955388942d1b23d4593d6c24c12572e'
    expect(described_class.signature(secret: '42', nonce: 1, body: 'test', method: 'get', request_uri: nil)).to eq '44624ec4718fbf23faf7cabe1b0528ef8b9ba28c097ff1e37c113ed476dfad1dfddf283b86b9cb005543f208def7c68b5872a4d2fce6659f36baf354a90f1e43'
    expect(described_class.signature(secret: '42', nonce: 1, body: 'test', method: 'GET', request_uri: nil)).to eq '44624ec4718fbf23faf7cabe1b0528ef8b9ba28c097ff1e37c113ed476dfad1dfddf283b86b9cb005543f208def7c68b5872a4d2fce6659f36baf354a90f1e43'
    expect(described_class.signature(secret: '42', nonce: 1, body: 'test', method: 'GET', request_uri: '/path')).to eq '5e8e7398a1c8c0cfe4e61fc0aa25cf4bfe405cf1fc46428178e44ee8ede9324026ba55d340892c41ea66e1d5ac5616fa3b319ed2e1941d4606f77ad82f48bfba'
  end
end
