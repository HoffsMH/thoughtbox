class Link < ActiveRecord::Base
  validates :url, :url => true
  validates :title, presence: true
end
