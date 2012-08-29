class Micropost < ActiveRecord::Base
	attr_accessible :content, :poster , :poster_id , :user_id, :poster_avatar
	belongs_to :user

	validates :content, :presence => true, :length => { :maximum => 140 }
	validates :user_id, :presence => true

	default_scope :order => 'microposts.created_at DESC'
end
