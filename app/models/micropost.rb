class Micropost < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  default_scope order: 'microposts.created_at DESC'

  # returns microposts from the users being followed by the given suer
  scope :from_users_followed_by, lambda { |user| followed_by(user) }

  def self.from_users_followed_by(user)
    followed_user_ids = user.followed_user_ids
    where("user_id IN (?) OR user_id = ?", followed_user_ids, user)
  end

  private

    # returns an sql conidition for users followed by the given user.
    # We include the user's own id as well.
    def self.followed_by(user)
      followed_user_ids = %(SELECT followed_id FROM relationships
                            WHERE follower_id = :user_id)
      puts "Followed user ids: #{followed_user_ids}"
      where("user_id IN (:followed_user_ids) OR user_id = :user_id",
            { followed_user_ids: followed_user_ids, user_id: user })
    end
end
