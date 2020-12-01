class ContentfulCdApi
  attr_reader :client

  def initialize space_id, access_token, environment
    @client = get_client space_id, access_token, environment
  end

  def get_post_entries
    @client.entries(content_type: 'post')
  end

  private
  def get_client space_id, access_token, environment
    Contentful::Client.new(
      space: space_id,
      access_token: access_token,
      environment: environment,
      dynamic_entries: :auto
    )
  end
end