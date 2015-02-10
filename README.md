# WebMock RSpec Helper

This gem provides a helper method `webmock` which makes it easier to stub requests.

## Installation

Add this line to your application's Gemfile and `bundle`:

```ruby
gem 'webmock-rspec-helper'
```

## Usage

Use the `webmock` method to map regular expressions to a filename. Files should be `spec/support/stubs`. The
`webmock` method will parse any digits between periods out of the filename to infer the status code (defaulting to 200).

Given the directory tree:

```
spec/
  support/
    stubs/
      GET_google.json
      GET_google.401.json
  webmock_spec.rb
```

You can use `webmock` within webmock_spec.rb like this:

`webmock :get, %r[google.com] => 'GET_google.json'`

Will stub requests to Google to return the contents of GET_google.json. Requests will return a 200 status code.

`webmock :get, %r[google.com] => 'GET_google.401.json'`

Will stub requests to Google to return the contents of GET_google.401.json. Requests will return a 401 status code.

Any options that need to go into `with` can be given as the return value of a block passed into `webmock`:

`webmock(:get, %r[:google.com] => 'GET_google.json') { Hash[query: { test: '123' }] }`

## Contributing

1. Fork it ( https://github.com/[my-github-username]/webmock-rspec-helper/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
