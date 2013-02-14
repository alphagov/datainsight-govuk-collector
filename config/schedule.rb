root_path = File.expand_path(File.dirname(__FILE__) + "/../")
set :output, {
    :standard => "#{root_path}/log/cron.out.log",
    :error => "#{root_path}/log/cron.err.log"
}
job_type :collector, "cd :path && RACK_ENV=:environment bundle exec collector --url=https://www.gov.uk/api/artefacts.json --formats=answer,smart-answer,programme,guide,transaction :task :output"



every :day, :at => '4am' do
  collector "broadcast"
end
