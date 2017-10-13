require 'webmock/rspec'
require 'rspec/expectations'
require 'rspec/mocks'
require 'logger'

require 'webrick'

require 'bugsnag-capistrano/deploy'
require 'bugsnag-capistrano/notifier'

describe Bugsnag::Capistrano::Deploy do
  describe "with notifier loadable", :with_notifier do

    before do
      require "bugsnag"
      Bugsnag.configure do |config|
        config.api_key = "TEST_API_KEY"
        config.release_stage = "production"
        config.logger = Logger.new(StringIO.new)
      end
    end

    after do
      Bugsnag.configuration.clear_request_data
    end
    
    it "should call notify_with_bugsnag" do
      expect(Bugsnag::Delivery::Synchronous).to receive(:deliver)
      Bugsnag::Capistrano::Deploy.notify()
    end
  end

  describe "without notifier loadable", :without_notifier do
    it "should call notify_without bugsnag" do
      expect(Bugsnag::Capistrano::Notifier).to receive(:deliver)
      Bugsnag::Capistrano::Deploy.notify({:api_key => "test"})
    end
  end
end