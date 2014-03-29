class SchoolRating < ActiveRecord::Base
  attr_accessible :name, :score
  validates :name, :presence => true, :uniqueness => true

  def first_or_create(name)
    SchoolRating.where(:name => name).first_or_create(:name => name, :score => 1)
  end
end
