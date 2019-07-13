# Detektiiv

Detektiiv discovers factory file path defined in other namespace that call from rails application.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'detektiiv'
```

And then execute:

    $ bundle

## Usage

Initialize Detektiiv after loading factory_bot gem.

```
Detektiiv.configure do |config|
  config.application_name = 'Rails application name'
  config.logfile_path = '/tmp/detektiiv.log'
end

Detektiiv.exec_patch!
```

Then running test. If there are calling factory defined in other namespace, below log shows up.

```
# Logfile created on 2019-07-13 13:33:02 +0900 by logger.rb/61378
{:filepath=>#<Proc:0x00007fb3a43c4c18@/Users/kamillle/sample_app/.bundle/bundler/gems/other_app/spec/factories/book.rb:3>}
{:caller=>"[\"/Users/kamillle/sample_app/spec/models/author_spec.rb:50:in `block (3 levels) in <top (required)>'\"]"}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/detektiiv. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
