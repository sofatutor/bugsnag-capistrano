# Tracking deploys with Bugsnag-Capistrano in Capistrano 2

This example demonstrates how to use Bugsnag-Capistrano to track deployments made with Capistrano 2.
Further details about tracking deploys with Bugsnag can be found [here.](https://docs.bugsnag.com/platforms/ruby/other/#tracking-deploys)

Install dependencies

```shell
bundle install
```

## Configuring Bugsnag with Capistrano

1. In the `Capfile`, require the bugsnag-capistrano library.
```ruby
require 'bugsnag-capistrano'
```

2. Then in the same file set the `:bugsnag_api_key` to your api key
```ruby
set :bugsnag_api_key, 'YOUR_API_KEY'
```

As an alternative, environment variables can be used to configure bugsnag-capistrano, for example setting the `api_key` with the `BUGSNAG_API_KEY` environment variable.

Further configuration options available to Capistrano read the [deploy-tracking guide.](https://docs.bugsnag.com/platforms/ruby/other/deploy-tracking/)


## Running the example

Now when your deployments are made with Capistrano Bugsnag will automatically be notified.

You can test this by running:
```shell
bundle exec cap deploy
```

And verify the deployment was successful by viewing the timeline in the [Bugsnag dashboard.](https://app.bugsnag.com)