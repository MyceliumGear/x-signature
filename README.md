# XSignature

This gem allows to cryptographically sign and verify API requests.

[![Build Status](https://travis-ci.org/MyceliumGear/x-signature.svg)](https://travis-ci.org/MyceliumGear/x-signature)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'x-signature'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install x-signature

## Usage

### Rails

In the controller:

```ruby
user = User.find(env['HTTP_X_CLIENT'])
if XSignature::RailsRequestValidator.new.valid?(request: request, secret: user.api_secret)
  # proceed
else
  # 401 error
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MyceliumGear/x-signature.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

