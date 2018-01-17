module Bugsnag
  module Capistrano
    def self.load_into(configuration)
      configuration.load do
        after "deploy",            "bugsnag:deploy"
        after "deploy:migrations", "bugsnag:deploy"

        namespace :bugsnag do
          desc "Notify Bugsnag that new production code has been deployed"
          task :deploy, :except => { :no_release => true }, :on_error => :continue do
            begin
              Bugsnag::Capistrano::Release.notify({
                :api_key => fetch(:bugsnag_api_key, ENV["BUGSNAG_API_KEY"]),
                :app_version => fetch(:app_version, ENV["BUGSNAG_APP_VERSION"]),
                :builder_name => fetch(:bugsnag_builder, ENV["BUGSNAG_BUILDER_NAME"], ENV["USER"])
                :metadata => fetch(:bugsnag_metadata)
                :release_stage => fetch(:bugsnag_env) || ENV["BUGSNAG_RELEASE_STAGE"] || fetch(:rails_env) || fetch(:stage) || "production",
                :revision => fetch(:current_revision, ENV["BUGSNAG_REVISION"]),
                :repository => fetch(:repo_url, ENV["BUGSNAG_REPOSITORY"]),
                :provider => fetch(:bugsnag_source_control_provider, ENV["BUGSNAG_SOURCE_CONTROL_PROVIDER"]),
                :endpoint => fetch(:bugsnag_endpoint)
              })
              logger.info "Bugsnag deploy notification complete."
            rescue
              logger.important("Bugnsag deploy notification failed, #{$!.inspect}")
            end
          end
        end
      end
    end
  end
end

Bugsnag::Capistrano.load_into(Capistrano::Configuration.instance) if Capistrano::Configuration.instance
