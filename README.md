# Yamcha

Yamcha is a Yaml Validator.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yamcha'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yamcha

## Usage

```ruby
yaml = {a: 1}.to_yaml
Yamcha::Validator.new(yaml).validate!
#=> {":a"=>"1"}
```

If there is a duplicated mapping key in the yaml, it occures raise `Yamcha::Validator::DuplicatedMappingKey::Error`.

```ruby
yaml = <<~YAML
---
a: 1
a: 2
YAML
Yamcha::Validator.new(yaml).validate!
#=> Yamcha::Validator::DuplicatedMappingKey::Error (duplicated key `a` exists)
```

If you would like to validate `*.yml` file itself, please try like the following example.

```ruby
Yamcha::Validator.new(File.read('./sample.yml')).validate!
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/yamcha. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Yamcha project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/yamcha/blob/master/CODE_OF_CONDUCT.md).
