require 'webmock/rspec'
require 'rspec/expectations'
require 'rspec/mocks'

require 'webrick'

describe "bugsnag capistrano 2", :cap_2 do

  server = nil
  queue = Queue.new
  example_path = File.join(File.dirname(__FILE__), '../examples/capistrano2')

  before do
    server = WEBrick::HTTPServer.new :Port => 0, :Logger => WEBrick::Log.new("/dev/null"), :AccessLog => []
    server.mount_proc '/deploy' do |req, res|
      queue.push req.body
      res.status = 200
      res.body = "OK\n"
    end
    Thread.new{ server.start }
  end

  after do
    server.stop
    queue.clear
  end

  let(:request) { JSON.parse(queue.pop) }
  
  it "sends a deploy notification to the set endpoint" do
    ENV['BUGSNAG_ENDPOINT'] = "localhost:" + server.config[:Port].to_s
    
    Dir.chdir(example_path) do
      system("bundle exec cap deploy")
    end

    payload = request()
    expect(payload["apiKey"]).to eq('YOUR_API_KEY')
    expect(payload["releaseStage"]).to eq('production')
    expect(payload["branch"]).to eq("master")
  end

  it "allows modifications of deployment characteristics" do
    ENV['BUGSNAG_ENDPOINT'] = "localhost:" + server.config[:Port].to_s
    ENV['BUGSNAG_API_KEY'] = "this is a test key"
    ENV['BUGSNAG_RELEASE_STAGE'] = "test"
    ENV['BUGSNAG_REVISION'] = "test"
    ENV['BUGSNAG_APP_VERSION'] = "1"
    ENV['BUGSNAG_REPOSITORY'] = "test@repo.com:test/test_repo.git"

    Dir.chdir(example_path) do
      system("bundle exec cap deploy > /dev/null 2>&1")
    end

    payload = request()
    expect(payload["apiKey"]).to eq('this is a test key')
    expect(payload["releaseStage"]).to eq('test')
    expect(payload["repository"]).to eq("test@repo.com:test/test_repo.git")
    expect(payload["branch"]).to eq("master")
    expect(payload["appVersion"]).to eq("1")
    expect(payload["revision"]).to eq("test")
  end
end

