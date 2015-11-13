class Post < ActiveRecord::Base
	acts_as_votable
	extend FriendlyId
	friendly_id :title, use: :slugged
	belongs_to :user
	has_many :comments
end
