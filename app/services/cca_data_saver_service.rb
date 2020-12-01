class CcaDataSaverService
  def initialize cca_parsed_data
    @cca_parsed_data = cca_parsed_data
  end

  def call
    @cca_parsed_data.each{|cca_data|
      author = cca_data[:author].present? ? Author.create!(cca_data[:author]) : nil
      post = Post.create!(cca_data[:post].merge(author: author))
      cca_data[:tags].each{|tag_data|
        tag = Tag.create!(tag_data)
        post_tag = PostTag.create!(post: post, tag: tag)
      }
      save_post_content(post, cca_data[:content])
    }
  end

  private
  def save_post_content post, content_data, parent_content=nil
    return if content_data.keys.size == 0

    marks = {}
    content_data["marks"].each{|mark| marks.merge!(mark)} if content_data["marks"].present?
    content = Content.create!(
      post: post,
      parent_content: parent_content,
      data: content_data["data"].present? ? content_data["data"] : {},
      node_type: content_data["nodeType"],
      marks: marks,
      value: content_data["value"]
    )

    if content_data["content"].present?
      content_data["content"].each{|c_data|
        save_post_content(nil, c_data, content)
      }
    end
  end
end