require 'clockwork'
require 'rake'
require './config/application.rb'

include Clockwork

handler do |job|
  puts "Running #{job}"
end

NayanPosts::Application.load_tasks
every 1.minute, "cron_job:fetch_from_contentful_cd_api_and_save_to_db"  do
  Rake::Task['cron_job:fetch_from_contentful_cd_api_and_save_to_db']
    .invoke()
  Rake::Task['cron_job:fetch_from_contentful_cd_api_and_save_to_db']
    .reenable()
end