class Post < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  scope :user_posts, -> (user_id) { where(user_id: user_id) }
  validates :content, presence: true,
                      length: { maximum: 500 }
  validates :user, presence: true
end
