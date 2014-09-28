class User < ActiveRecord::Base
    before_save { |user| user.email = email.downcase } # p253

    before_save :create_remember_token # p348

    #p264 said to add this. (But know it requires [gem 'protected_attributes'] in Gemfile):
    #attr_accessible :name, :email, :password
    # internet says is auto:
    # , :password_confirmation


    has_secure_password
    has_many :microposts, dependent: :destroy  # p438, #p443 updated.

    # p493 added:
    has_many :relationships, foreign_key: "follower_id", dependent: :destroy

    # p496 added:
    has_many :followed_users, through: :relationships, source: :followed 


    # p502 added:
    has_many :reverse_relationships, foreign_key: "followed_id",
                                                  class_name: "Relationship",
                                                  dependent: :destroy
    # p502 too added:                                                  
    has_many :followers, through: :reverse_relationships, source: :follower                                                


	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i # p246

	validates :name,  presence: true, length: { maximum: 50 }    # p240, p244
	validates :email,        # p243
	         presence: true, # p243
	         format: { with: VALID_EMAIL_REGEX }, # p246
	         uniqueness:  { case_sensitive: false } # p250, p251
	         
	# p264:
	validates :password, presence: true, length: { minimum: 6 }  # p264
	validates :password_confirmation, presence: true             # p264

  def feed # p469 first version.
    # p469, gone p532: Micropost.where("user_id = ?", id)
    Micropost.from_users_followed_by(self) # p532 added.
  end

  # p498 added:
  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  # p498 added:
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  # p500:  
  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

private
  def create_remember_token
  	self.remember_token = SecureRandom.urlsafe_base64
  end
	
end
