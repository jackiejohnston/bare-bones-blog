class Post < ActiveRecord::Base
  default_scope -> { order('created_at DESC') }
  extend FriendlyId
  friendly_id :headline, use: [:slugged, :history]
  validates_presence_of :headline, :slug, :intro, :article

  def should_generate_new_friendly_id?
    headline_changed?
  end
end
