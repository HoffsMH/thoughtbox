class Link < ActiveRecord::Base
  validates :url, :url => true
  validates :title, presence: true
  validates :user_id, presence: true
end
