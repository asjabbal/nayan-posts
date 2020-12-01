class Post < ApplicationRecord
  belongs_to :author
  has_many :post_tags
  has_many :tags, through: :post_tags
  has_one :content

  def content_html
    content.present? ? content.html_str : ""
  end

  def author_name
    author.present? ? author.name : "N/A"
  end
end
