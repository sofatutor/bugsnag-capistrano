require 'webmock/rspec'
require 'rspec/expectations'
require 'rspec/mocks'
require 'logger'

require 'webrick'

require 'bugsnag-capistrano/notifier'

describe "bugsnag capistrano notifier", :notifier do
  it "delivers a request to the given url" do
    url = "http://localhost:56456"
    stub_request(:post, url)
      .to_return(status:200, body: "")
    Bugsnag::Capistrano::Notifier.deliver(url, nil)
  end

  it "delivers a body unmodified" do
    body = {
      "paramA" => 'a',
      "paramB" => 'b',
      "paramHash" => {
        "one" => 1,
        "two" => 2,
        "three" => 3
      }
    }
    url = "http://localhost:56456"
    stub_request(:post, url)
      .with(body: body, headers: { 'Content-Type' => 'application/json'})
      .to_return(status:200, body: "")
    Bugsnag::Capistrano::Notifier.deliver(url, body)
  end
end