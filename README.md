# Bugsnag deploy tracking with Capistrano
[![Build status](https://travis-ci.org/bugsnag/bugsnag-bugsnag-capistrano.svg?branch=master)](https://travis-ci.org/bugsnag/bugsnag-bugsnag-capistrano)


Bugsnag Capistrano automatically notifies Bugsnag when you deploy your
application with [Capistrano](https://github.com/capistrano/capistrano),
allowing to correlate deploys with new errors and increased error rates in
Bugsnag.

[Bugsnag](http://bugsnag.com) captures errors in real-time from your web,
mobile and desktop applications, helping you to understand and resolve them
as fast as possible. [Create a free account](http://bugsnag.com) to start
capturing exceptions from your applications.

## Features

* Automatically report unhandled exceptions and crashes
* Report handled exceptions
* Log breadcrumbs which are attached to crash reports and add insight to users' actions
* Attach user information and custom diagnostic data to determine how many people are affected by a crash

## Getting started

1. [Create a Bugsnag account](https://bugsnag.com)
1. Complete the instructions in the [ruby integration guide](https://docs.bugsnag.com/platforms/ruby/) for your ruby application type
1. Complete the instructions in the integration guide for [deploy tracking](https://docs.bugsnag.com/platforms/ruby/deploy-tracking/)
1. Report handled exceptions using [`Bugsnag.notify()`](http://docs.bugsnag.com/platforms/bugsnag-capistrano/reporting-handled-exceptions/)
1. Customize your integration using the [configuration options](http://docs.bugsnag.com/platforms/bugsnag-capistrano/configuration-options/)

## Support

* Read the [bugsnag-capistrano](http://docs.bugsnag.com/platforms/bugsnag-capistrano/configuration-options) configuration reference
* Read the instructions in the integration guide for [deploy tracking](https://docs.bugsnag.com/platforms/ruby/deploy-tracking/)
* [Search open and closed issues](https://github.com/bugsnag/bugsnag-bugsnag-capistrano/issues?utf8=✓&q=is%3Aissue) for similar problems
* [Report a bug or request a feature](https://github.com/bugsnag/bugsnag-bugsnag-capistrano/issues/new)

## Contributing

All contributors are welcome! For information on how to build, test,
and release `bugsnag-bugsnag-capistrano`, see our
[contributing guide](https://github.com/bugsnag/bugsnag-bugsnag-capistrano/blob/master/CONTRIBUTING.md).


## License

The Bugsnag Cocoa library is free software released under the MIT License.
See [LICENSE.txt](https://github.com/bugsnag/bugsnag-bugsnag-capistrano/blob/master/LICENSE.txt)
for details.
