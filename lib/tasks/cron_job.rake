namespace :cron_job do

  desc "Fetch data from Nayan's Contentful Content Delivery Api and save to database"
  task :fetch_from_contentful_cd_api_and_save_to_db => :environment do
    puts "--- Starting task -> cron_job:fetch_from_contentful_cd_api_and_save_to_db ---"
    puts "--- Fetching data from Contentful CD API(CCA) ---"

    api = ContentfulCdApi.new(ENV['contentful_cd_api.space_id'],
      ENV['contentful_cd_api.access_token'],
      ENV['contentful_cd_api.environment_id']
    )
    cca_entries = api.get_post_entries

    puts "--- Data fetched from CCA ---"
    puts "--- Started CCA data parsing ---"

    parser = CcaDataParser.new(cca_entries)
    parsed_data = parser.parse

    puts "--- Data parsed from CCA ---"
    puts "--- Started service to save CCA data ---"

    service = CcaDataSaverService.new(parsed_data)
    service.call

    puts "--- CCA data saved to DB ---"
    puts "--- DONE ---"
  end

end