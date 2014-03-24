# Fist of Fury

[![Build Status](https://travis-ci.org/facto/fist_of_fury.png?branch=master)](https://travis-ci.org/facto/fist_of_fury)
[![Dependency Status](https://gemnasium.com/facto/fist_of_fury.svg)](https://gemnasium.com/facto/fist_of_fury)
[![Coverage Status](https://coveralls.io/repos/facto/fist_of_fury/badge.png)](https://coveralls.io/r/facto/fist_of_fury)
[![Code Climate](https://codeclimate.com/github/facto/fist_of_fury.png)](https://codeclimate.com/github/facto/fist_of_fury)
[![Gem Version](https://badge.fury.io/rb/fist_of_fury.png)](http://badge.fury.io/rb/fist_of_fury)

Recurring jobs for [Sucker Punch](https://github.com/brandonhilkert/sucker_punch).

## Why

Sucker Punch offers the ability to run background jobs *within the web server process*. Yes, this means you can host your app on Heroku without paying for an extra dyno for background jobs. However, Sucker Punch does not implement recurring jobs. Enter Fist of Fury!

## What

Fist of Fury is heavily inspired by [Sidetiq](https://github.com/tobiassvn/sidetiq) for [Sidekiq](https://github.com/mperham/sidekiq). It uses the [ice_cube](https://github.com/seejohnrun/ice_cube) gem for easy creation of recurrence rules.

## Installation

Add this line to your application's Gemfile:

    gem 'fist_of_fury', '~> 0.1.0'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fist_of_fury

## Usage

You can schedule your jobs within the jobs themselves:

```Ruby
# app/jobs/say_hi_job.rb

class SayHiJob
  include SuckerPunch::Job
  include FistOfFury::Recurrent

  recurs { minutely }

  def perform
    Rails.logger.info 'Hi!'
  end
end
```

Then in the initializer:

```Ruby
# config/initializers/fist_of_fury.rb

# Ensures the jobs run only in a web server.
if defined?(Rails::Server)
  FistOfFury.attack!
end
```

Or you can even specify the recurrence rules all within the initializer:

```Ruby
# config/initializers/fist_of_fury.rb

# Ensures the jobs run only in a web server.
if defined?(Rails::Server)
  FistOfFury.attack! do
    LogJob.recurs { secondly(3) }
  end
end
```

## Configuration Options

In the initializer:

```Ruby
FistOfFury.configure do |config|
  config.utc = true # false by default; makes all time within Fist of Fury UTC
end
```

## Contributing

1. Fork it ( http://github.com/facto/fist_of_fury/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/facto/fist_of_fury/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

