class Content < ApplicationRecord
  belongs_to :post
  has_many :child_contents, class_name: 'Content', foreign_key: 'parent_content_id'
  belongs_to :parent_content, class_name: 'Content', foreign_key: 'parent_content_id'

  def html_str
    html_tag = html_tags
    mark_tag = mark_tags
    html = []
    html << html_tag[:st] + mark_tag[:st]
    
    if value.present?
      html << value
    else
      if child_contents.present?
        content_html = ""
        child_contents.each{|child_content|
          content_html += child_content.html_str
        }
        html << content_html
      end
    end

    html << html_tag[:et] + mark_tag[:et]
    html.join("")
  end

  private
  def html_tags
    case node_type
    when "document"
      {st: "<div>", et: "</div>"}
    when "paragraph"
      {st: "<p>", et: "</p>"}
    when "list-item"
      {st: "<li>", et: "</li>"}
    when "unordered-list"
      {st: "<ul>", et: "</ul>"}
    else
      {st: "", et: ""}
    end
  end

  def mark_tags
    case marks["type"]
    when "bold"
      {st: "<b>", et: "</b>"}
    when "italic"
      {st: "<i>", et: "</i>"}
    else
      {st: "", et: ""}
    end
  end
end
