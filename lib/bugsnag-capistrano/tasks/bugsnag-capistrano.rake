require "bugsnag"

namespace :bugsnag do

  desc "Notify Bugsnag of a new deploy."
  task :deploy do
    api_key = ENV["BUGSNAG_API_KEY"]
    release_stage = ENV["BUGSNAG_RELEASE_STAGE"]
    app_version = ENV["BUGSNAG_APP_VERSION"]
    revision = ENV["BUGSNAG_REVISION"]
    repository = ENV["BUGSNAG_REPOSITORY"]
    branch = ENV["BUGSNAG_BRANCH"]

    Rake::Task["load"].invoke unless api_key

    Bugsnag::Deploy.notify({
      :api_key => api_key,
      :release_stage => release_stage,
      :app_version => app_version,
      :revision => revision,
      :repository => repository,
      :branch => branch
    })
  end

end

task :load do
  begin
    Rake::Task["environment"].invoke
  rescue
  end
end
