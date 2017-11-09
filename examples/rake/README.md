# Tracking deploys with Rake

This example illustrates how to track app deploys using Rake.
Further details about tracking deploys with Bugsnag can be found [here.](https://docs.bugsnag.com/platforms/ruby/other/#tracking-deploys)

## Configuration

1. In your Gemfile, add `bugsnag-capistrano`:

   ```ruby
   gem 'bugsnag-capistrano
   ```

   Install dependencies:

   ```
   bundle install
   ```

2. Require `bugsnag-capistrano/tasks` in your Rakefile:

   ```ruby
   require 'bugsnag-capistrano/tasks'
   ```

## Usage

Run the `bugsnag:deploy` including your API key, release stage, and app version:

```
rake bugsnag:deploy BUGSNAG_API_KEY=YOUR-API-KEY \
                    BUGSNAG_RELEASE_STAGE=production
```
