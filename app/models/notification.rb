class Notification < ApplicationRecord
  belongs_to :user

  enum notification_type: { post: 'post', comment: 'comment', follow: 'follow', unfollow: 'unfollow' }

  scope :unread, -> { where(read: false) }

  def mark_as_read
    update(read: true)
  end
end
