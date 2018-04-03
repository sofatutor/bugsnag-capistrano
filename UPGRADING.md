# Upgrade Guide

## 1.x to 2.x

_Our Capistrano build-integration has changed to accommodate changes to our [Build API](https://docs.bugsnag.com/build-integrations/), and there may be changes required to continue to notify of your Capistrano releases_

#### Heroku

Heroku deployment notifications have been removed from this gem. You can find information on how to set up a Heroku deploy hook at [our documentation](https://docs.bugsnag.com/build-integrations/heroku/).

#### Rake

Rake deployment notifications have been removed from this gem. While we don't have an explicit replacement for the Rake tasks, information on how to send a build notification can be found in [our Build API documentation](https://docs.bugsnag.com/build-integrations/).

#### Task names

The task `:deploy` has been renamed to `:release`. Any references to it should be renamed accordingly.

#### Configuration

- `branch` has been removed.
- `bugsnag_builder` has been added. This should be the name of the person or machine that has triggered the release. Can also be set using the environment variables `BUGSNAG_BUILDER_NAME` or `USER`.  Will default to the result of the `whoami` command on the releasing machine.
- `bugsnag_auto_assign_release` has been added.  Thi#s will ensure **all** event notifications received will be assigned to this release. This should only be used if you are not using the `app_version` configuration option within your application.  Can be set using the environment variable `BUGSNAG_AUTO_ASSIGN_RELEASE`.  Will default to `false`.
- `bugsnag_source_control_provider` has been added. This contains the type of on-premise server the application uses for source-control, and therefore should only be used if an on-premise source-control solution is used. Valid settings are: `github-enterprise`, `gitlab-onpremise`, and `bitbucket-server`. Can be set using the environment variable `BUGSNAG_SOURCE_CONTROL_PROVIDER`. Defaults to `nil`.
- `bugsnag-metadata` has been added. This should be a hash containing any additional data you wish to attach to your release notification.

A full list of configuration options can be found at the [Capistrano build-integration guide](https://docs.bugsnag.com/build-integrations/capistrano/).