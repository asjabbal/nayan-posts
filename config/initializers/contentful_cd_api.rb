#Set environment variables that are available globally and can be used across the app.
#if File.exists?(file)

file = File.join(Rails.root, 'config', 'api_config.yml')
api_config = YAML.load(File.open(file))[Rails.env]['contentful_cd_api']

api_config.each do |key, value|
  ENV['contentful_cd_api.' + key.to_s] = value
end