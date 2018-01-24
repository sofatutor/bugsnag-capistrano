require 'webmock/rspec'
require 'rspec/expectations'
require 'rspec/mocks'
require 'logger'
require 'json'

require 'webrick'

require 'bugsnag-capistrano/release'

describe Bugsnag::Capistrano::Release do
  describe "without notifier loadable", :without_notifier do
    it "should call notify_without bugsnag" do
      expect(Bugsnag::Capistrano::Release).to receive(:deliver)
      Bugsnag::Capistrano::Release.notify({:api_key => "test"})
    end
  end

  describe "the delivery function", :always do
    it "delivers a request to the given url" do
      url = "http://localhost:56456"
      stub_request(:post, url)
        .to_return(status:200, body: "")
      Bugsnag::Capistrano::Release.deliver(url, nil)
    end

    it "delivers a body unmodified" do
      body = ::JSON.dump({
        "paramA" => 'a',
        "paramB" => 'b',
        "paramHash" => {
          "one" => 1,
          "two" => 2,
          "three" => 3
        }
      })
      url = "http://localhost:56456"
      request = stub_request(:post, url)
        .with(body: body, headers: { 'Content-Type' => 'application/json'})
        .to_return(status:200, body: "")
      Bugsnag::Capistrano::Release.deliver(url, body)
      assert_requested request
    end
  end
end
