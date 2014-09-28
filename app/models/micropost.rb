class Micropost < ActiveRecord::Base
	#attr_accessible :content  # p436, FIXME to strong-params through controller.
	# not attr access.
	belongs_to :user	#p438.

  validates :user_id, presence: true # p433
  validates :content, presence: true, length: { maximum: 140 }  # p444.

	default_scope order: 'microposts.created_at DESC'   # p441

  # Returns microposts from the useres being followed by the given user:
  # p535 added:
  #def self.from_users_followed_by(user)
  #  # p536 removed: where("user_id IN (?) OR user_id = ?", followed_user_ids, user) 
  #  # p537 using named placeholders.
  #  followed_user_ids = user.followed_user_ids
  #  where("user_id IN (:followed_user_ids) OR user_id = :user_id", 
  #    followed_user_ids: followed_user_ids, user_id: user)  
  #end

  # Returns microposts from the useres being followed by the given user:
  # p538, new version of from_users_followed_by:
  def self.from_users_followed_by(user)
    followed_user_ids = 
    " SELECT followed_id FROM relationships
      WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
      user_id: user.id)
  end

end
