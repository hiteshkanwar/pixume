class Achievement < ActiveRecord::Base
  attr_accessible :title, :description, :achievement, :category
  belongs_to :user

  validates :title, :description, :presence => true
  validates :title, :length => { :maximum => 100 }
  validates :description, :length => { :maximum => 140 }
  validates :category, :length => { :maximum => 50 }
  validates :achievement, :format => { :with => /\d{1,2}[0]{0,1}/ }
end
