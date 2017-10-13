require "net/https"
require "uri"

module Bugsnag
  module Capistrano
    class Notifier
      HEADERS = {"Content-Type" => "application/json"}

      class << self
        def deliver(url, body)
          logger = Logger.new(STDOUT)
          logger.level = Logger::INFO
          begin
            response = request(url, body)
            logger.debug("Notification to #{url} finished, response was #{response.code}, payload was #{body}")
          rescue StandardError => e
            logger.warn("Notification to #{url} failed, #{e.inspect}")
            logger.warn(e.backtrace)
          end
        end

        private 
        def request(url, body)
          uri = URI.parse(url)
          http = Net::HTTP.new(uri.host, uri.port)
          http.read_timeout = 15
          http.open_timeout = 15

          if uri.scheme == "https"
            http.use_ssl = true
          end

          request = Net::HTTP::Post.new(path(uri), HEADERS)
          request.body = body
          http.request(request)
        end

        def path(uri)
          uri.path == "" ? "/" : uri.path
        end
      end
    end
  end
end
