# Fist of Fury

[![Build Status](https://travis-ci.org/facto/fist_of_fury.png?branch=master)](https://travis-ci.org/facto/fist_of_fury)
[![Coverage Status](https://coveralls.io/repos/facto/fist_of_fury/badge.png)](https://coveralls.io/r/facto/fist_of_fury)

Recurring jobs for [Sucker Punch](https://github.com/brandonhilkert/sucker_punch).

**This is alpha software. Use at your own risk!**

## Why

Sucker Punch offers the capability to run background jobs within the web server process, allowing for less use of resources and utilization of free hosting on services such as Heroku. However, it does not include the ability to run jobs at scheduled intervals. This is where Fist of Fury comes in.

## What

Fist of Fury is heavily inspired by [Sidetiq](https://github.com/tobiassvn/sidetiq) for [Sidekiq](https://github.com/mperham/sidekiq). It uses the [ice_cube](https://github.com/seejohnrun/ice_cube) gem for easy creation of recurrence rules.

## Installation

Add this line to your application's Gemfile:

    gem 'fist_of_fury', '~> 0.1'

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

# Ensures the jobs don't run while in the Rails console.
unless defined?(Rails::Console)
  FistOfFury.attack!
end
```

Or you can even specify the recurrence rules all within the initializer:

```Ruby
# config/initializers/fist_of_fury.rb

# Ensures the jobs don't run while in the Rails console.
unless defined?(Rails::Console)
  FistOfFury.attack! do
    LogJob.recurs { secondly(3) }
  end
end
```


## Contributing

1. Fork it ( http://github.com/<my-github-username>/fist_of_fury/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
