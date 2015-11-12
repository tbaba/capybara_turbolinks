# Capybara Turbolinks

Extends Capybara with methods that mitigate race conditions introduced by Turbolinks caching.

Turbolinks is a page loading mechanism introduced in Rails 4.  It's default behaviour is to cache pages on the client side, so that page loading appears extremely fast.  This caching (and Turbolinks itself) can be problematic; the shopify team decided to [disable caching entirely](https://github.com/rails/turbolinks/issues/551).  We decided to keep the page caching, because it was so fast.  However, we experienced race conditions in our integration tests. 

From a Capybara and integration test point of view, the caching is problematic because it loads the page twice; once with the cached page, and a second time with the actual page from the server.

This causes issues with integration tests that block until they see certain page content or selectors, because the integration tests continue before the *actual* page has been loaded from the server.

This gem's solution is to add a small amount of JavaScript code in the test environment that adds and removes classes to the body tag that correspond to the Turbolinks page lifecycle.  This allows us to use Capybara #has_css? to block until we have detected that the Turbolinks request is complete.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capybara_turbolinks'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capybara_turbolinks

## Usage

This gem extends Capybara by adding two additional methods:

```ruby
Capybara::Node::Actions#click_turbolink
```

and

```ruby
Capybara::Node::Element#turboclick
``` 
  
When you are clicking a link that triggers turbolinks, you will need to use one of the above methods.  For example:

```ruby
  visit root_path
  click_turbolink 'View all deals'
```

Or when you are finding an element to click on:

```ruby
  visit root_path
  find('a.all-deals').turboclick
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Loft47/capybara_turbolinks.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

