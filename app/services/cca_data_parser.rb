class CcaDataParser
  def initialize cca_entries
    @cca_entries = cca_entries
  end

  def parse
    parsed_data = []

    @cca_entries.each{|cca_entry|
      parsed_data << {
        post: build_post_hash(cca_entry),
        content: build_content_hash(cca_entry),
        author: build_author_hash(cca_entry),
        tags: build_tags_hash(cca_entry)
      }
    }

    parsed_data
  end

  private
  def build_post_hash cca_entry
    cca_post_fields = cca_entry.fields

    {
      external_id: cca_entry.id,
      title: cca_post_fields[:title],
      image_url: cca_post_fields[:photo].present? ? cca_post_fields[:photo].url : nil
    }
  end

  def build_author_hash cca_entry
    cca_post_fields = cca_entry.fields

    return nil if cca_post_fields[:author].blank?

    {
      external_id: cca_post_fields[:author].id,
      name: cca_post_fields[:author].name
    }
  end

  def build_tags_hash cca_entry
    cca_post_fields = cca_entry.fields

    tags = []

    return tags if cca_post_fields[:tags].blank? || cca_post_fields[:tags].empty?

    cca_post_fields[:tags].each{|cca_post_tag|
      tag = {
        external_id: cca_post_tag.id,
        name: cca_post_tag.name
      }

      tags << tag
    }

    tags
  end

  def build_content_hash cca_entry
    cca_post_fields = cca_entry.fields

    cca_post_fields[:content].present? ? cca_post_fields[:content] : {}
  end
end