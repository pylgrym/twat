class Relationship < ActiveRecord::Base

  # fixme, attr_accessible for followed_id

  # p494 added:
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  # p495 added:
  validates :follower_id, presence: true
  validates :followed_id, presence: true

end
