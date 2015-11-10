require 'redis'

module XSignature
  class RedisNonceValidator < NonceValidator

    attr_accessor :redis_connection, :keys_prefix

    def initialize(redis_connection: nil, keys_prefix: 'XSignature:LastNonce:')
      @redis_connection = redis_connection || Redis.current rescue StandardError.new('Bad redis connection')
      @keys_prefix      = keys_prefix
    end

    def valid?(data)
      key = "#{keys_prefix}#{data.client}"
      loop do
        redis_connection.watch key do
          last_nonce = redis_connection.get(key).to_i
          if last_nonce < data.nonce
            result = redis_connection.multi do |multi|
              multi.set key, data.nonce
            end
            return true if result[0] == 'OK'
          else
            redis_connection.unwatch
            return false
          end
        end
      end
    end
  end
end
