require 'spec_helper'
require 'rails'
require 'action_controller/railtie'
require 'action_dispatch/railtie'
require 'rspec/rails'

module Rails
  class App
    def env_config
      {}
    end

    def routes
      @routes ||= begin
        ActionDispatch::Routing::RouteSet.new.tap do |routes|
          routes.draw do
            post 'test', to: 'test#test'
          end
        end
      end
    end
  end

  def self.application
    @app ||= App.new
  end
end

class TestController < ActionController::Base
  include Rails.application.routes.url_helpers

  def test
    nonce_validator = Object.new

    def nonce_validator.valid?(*)
      true
    end

    request_validator = XSignature::RailsRequestValidator.new(nonce_validator: nonce_validator)
    @valid            = request_validator.valid?(request: request, secret: 42)
    render nothing: true
  end
end

describe TestController, type: :controller do

  it "accepts valid hex signature" do
    @request.headers['X-Nonce']     = '1445887801'
    @request.headers['X-Signature'] = '4c8b843102403a0230251608080679b74fffc18161dea6d6a87f4c97bbbe4abca5b2199068166899dd5c288f5bc86c6b63ae1e14481f9d6fc9efa280c10bfb25'
    @request.env['REQUEST_URI']     = '/path'
    post :test, 'test'
    expect(assigns(:valid)).to eq true
  end

  it "accepts valid base64 signature" do
    @request.headers['X-Nonce']     = '1445887801'
    @request.headers['X-Signature'] = "qIjDrJaQaR1ABw9emv9btW0/unt3AzTe2jbuOooJQ2PwxtEKeks2bph+xD4e0cu+kLJloqDN/MXKXPguRZrXFQ=="
    @request.env['REQUEST_URI']     = '/path'
    post :test, 'test'
    expect(assigns(:valid)).to eq true
  end

  it "handles incorrect REQUEST_URI with a domain name included" do
    @request.headers['X-Nonce']     = '1445887801'
    @request.headers['X-Signature'] = "qIjDrJaQaR1ABw9emv9btW0/unt3AzTe2jbuOooJQ2PwxtEKeks2bph+xD4e0cu+kLJloqDN/MXKXPguRZrXFQ=="
    @request.env['REQUEST_URI']     = 'http://www.example.com/path'
    post :test, 'test'
    expect(assigns(:valid)).to eq true
  end

  it "rejects invalid signature" do
    @request.headers['X-Nonce']     = '1445887801'
    @request.headers['X-Signature'] = 'meah'
    @request.env['REQUEST_URI']     = '/path'
    post :test, 'test'
    expect(assigns(:valid)).to eq false
  end
end
