# Fist of Fury

## DEPRECATED: This project is no longer maintained. I recommend using it only for messing around with the concept.

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

    gem 'fist_of_fury', '~> 0.2.0'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fist_of_fury

### Rails

Run the install generator, which installs an initializer:

    $ rails generate fist_of_fury:install

## Usage

You can schedule your jobs within the jobs themselves:

```Ruby
class SayHiJob
  include SuckerPunch::Job
  include FistOfFury::Recurrent

  recurs { minutely }

  def perform
    Rails.logger.info 'Hi!'
  end
end
```

**GOTCHA WARNING:** If you define the recurrence rules within the job classes themselves, you may run into an issue where your jobs never run in development. By default, Rails does not eager load code in development, and thus will not load your job classes, resulting in your jobs not being scheduled. Either set `config.eager_load = true` in `development.rb` or reference your job classes somewhere in an initializer (`config/fist_of_fury.rb` is a good candidate).

If you did not run the install generator, you need to kick off the process somewhere (like an initializer) with this:

```Ruby
FistOfFury.attack!
```

You can specify the recurrence rules during kickoff:

```Ruby
FistOfFury.attack! do
  LogJob.recurs { secondly(3) }
end
```

## Configuration Options

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

