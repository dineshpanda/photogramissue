class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  # Direct associations
  has_many :access_grants,
           class_name: "Doorkeeper::AccessGrant",
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens,
           class_name: "Doorkeeper::AccessToken",
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks

  has_many   :accepted_sent_friend_requests,
             -> { accepted },
             class_name: "FriendRequest",
             foreign_key: "sender_id",
             dependent: :destroy

  has_many   :received_friend_requests,
             class_name: "FriendRequest",
             foreign_key: "recipient_id",
             dependent: :destroy

  has_many   :sent_friend_requests,
             class_name: "FriendRequest",
             foreign_key: "sender_id",
             dependent: :destroy

  has_many   :comments,
             foreign_key: "commenter_id",
             dependent: :destroy

  has_many   :likes,
             class_name: "Vote",
             dependent: :destroy

  has_many   :photos,
             foreign_key: "owner_id",
             dependent: :destroy

  # Indirect associations

  has_many   :followers,
             through: :received_friend_requests,
             source: :accepted_sender

  has_many   :following,
             through: :accepted_sent_friend_requests,
             source: :recipient

  has_many   :liked_photos,
             through: :likes,
             source: :photo

  has_many   :commented_photos,
             through: :comments,
             source: :photo

  # Validations

  validates :username, uniqueness: true

  validates :username, presence: true

  # Scopes

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
