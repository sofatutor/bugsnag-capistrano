require "json"
require_relative "notifier"

module Bugsnag
  module Capistrano
    class Deploy

      DEFAULT_DEPLOY_ENDPOINT = "https://notify.bugsnag.com"

      def self.notify(opts = {})
        begin
          require 'bugsnag'
          self.notify_using_bugsnag(opts)
        rescue LoadError => e
          self.notify_without_bugsnag(opts)
        end
      end

      def self.notify_using_bugsnag(opts = {})

        configuration = Bugsnag.configuration.dup

        [:api_key, :app_version, :release_stage, :endpoint, :use_ssl,
        :proxy_host, :proxy_port, :proxy_user, :proxy_password].each do |param|
          unless opts[param].nil?
            configuration.send :"#{param}=", opts[param]
          end
        end

        if Gem::Version.new(Bugsnag::VERSION).release >= Gem::Version.new('6.0.0')
          endpoint = configuration.endpoint + "/deploy"
        else
          endpoint = (configuration.use_ssl ? "https://" : "http://") + configuration.endpoint + "/deploy"
        end

        parameters = {
          "apiKey" => configuration.api_key,
          "releaseStage" => configuration.release_stage,
          "appVersion" => configuration.app_version,
          "revision" => opts[:revision],
          "repository" => opts[:repository],
          "branch" => opts[:branch]
        }.reject {|k,v| v == nil}

        raise RuntimeError.new("No API key found when notifying of deploy") if !parameters["apiKey"] || parameters["apiKey"].empty?


        payload_string = ::JSON.dump(parameters)
        Bugsnag::Delivery::Synchronous.deliver(endpoint, payload_string, configuration)
      end
      
      def self.notify_without_bugsnag(opts = {})
        endpoint = (opts[:endpoint].nil? ? DEFAULT_DEPLOY_ENDPOINT : opts[:endpoint]) + "/deploy"

        parameters = {
          "apiKey" => opts[:api_key],
          "releaseStage" => opts[:release_stage],
          "appVersion" => opts[:app_version],
          "revision" => opts[:revision],
          "repository" => opts[:repository],
          "branch" => opts[:branch]
        }.reject {|k, v| v == nil}
        
        raise RuntimeError.new("No API key found when notifying of deploy") if !parameters["apiKey"] || parameters["apiKey"].empty?

        payload_string = ::JSON.dump(parameters)
        Bugsnag::Capistrano::Notifier.deliver(endpoint, payload_string)
      end
    end
  end
end
