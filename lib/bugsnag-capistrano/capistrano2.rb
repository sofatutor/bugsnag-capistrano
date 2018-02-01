module Bugsnag
  module Capistrano
    def self.load_into(configuration)
      configuration.load do
        after "deploy",            "bugsnag:release"
        after "deploy:migrations", "bugsnag:release"

        namespace :bugsnag do
          desc "Notify Bugsnag that new production code has been released"
          task :release, :except => { :no_release => true }, :on_error => :continue do
            begin
              Bugsnag::Capistrano::Release.notify({
                :api_key => fetch(:bugsnag_api_key, ENV["BUGSNAG_API_KEY"]),
                :app_version => fetch(:app_version, ENV["BUGSNAG_APP_VERSION"]),
                :builder_name => fetch(:bugsnag_builder, ENV["BUGSNAG_BUILDER_NAME"] || ENV["USER"]),
                :metadata => fetch(:bugsnag_metadata, nil),
                :release_stage => fetch(:bugsnag_env) || ENV["BUGSNAG_RELEASE_STAGE"] || fetch(:rails_env) || fetch(:stage) || "production",
                :revision => fetch(:current_revision, ENV["BUGSNAG_REVISION"]),
                :repository => fetch(:repo_url, ENV["BUGSNAG_REPOSITORY"]),
                :source_control_provider => fetch(:bugsnag_source_control_provider, ENV["BUGSNAG_SOURCE_CONTROL_PROVIDER"]),
                :endpoint => fetch(:bugsnag_endpoint, nil)
              })
              logger.info "Bugsnag release notification complete."
            rescue
              logger.important("Bugnsag release notification failed, #{$!.inspect}")
            end
          end
        end
      end
    end
  end
end

Bugsnag::Capistrano.load_into(Capistrano::Configuration.instance) if Capistrano::Configuration.instance
