class BlogPost < ApplicationRecord
  has_rich_text :content

  validates :title, presence: true
  validates :content, presence: true

  scope :ordered, -> { order(id: :desc) }
  scope :draft, -> { where(published_at: nil) }
  scope :published, -> { where('published_at <= ?', Time.current) }
  scope :scheduled, -> { where('published_at > ?', Time.current) }

  def draft?
    published_at.nil?
  end

  def published?
    published_at? && published_at <= Time.current
  end

  def scheduled?
    published_at? && published_at > Time.current
  end

  # after_create_commit -> { broadcast_prepend_later_to 'blog_posts', partial: "blog_posts/blog_post", locals: { blog_post: self } }
  # after_update_commit -> { broadcast_replace_later_to 'blog_posts', partial: "blog_posts/blog_post", locals: { blog_post: self } }
  # after_destroy_commit -> { broadcast_remove_to 'blog_posts' }

  broadcasts_to ->(blog_post) { "blog_posts" }, inserts_by: :prepend
end
