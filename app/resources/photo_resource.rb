class PhotoResource < ApplicationResource
  attribute :id, :integer, writable: false
  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false
  attribute :caption, :string
  attribute :image, :string
  attribute :location, :string
  attribute :owner_id, :integer

  # Direct associations

  has_many   :comments

  has_many   :likes,
             resource: VoteResource

  belongs_to :owner,
             resource: UserResource

  # Indirect associations

  many_to_many :fans,
               resource: UserResource

  many_to_many :commenters,
               resource: UserResource
end
