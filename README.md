# Fist of Fury

Recurring jobs for [Sucker Punch](https://github.com/brandonhilkert/sucker_punch).

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
