class Education < ActiveRecord::Base
  attr_accessible :user_id, :institute, :course, :from_month, :from_year, :to_year, :location, :to_month, :to_year, 
                  :linkedin_id #:title, :body
                  
  belongs_to :user
  
  validates :institute, :course, :presence => true
  validates :linkedin_id, :uniqueness => {:scope => [:user_id]}, :allow_nil => true
  
  def self.create_from_linkedin user, educations
    unless educations.blank?
      educations.each do |education|
        Education.create(:user_id => user.id, :institute => education.school_name, :course => education.degree, 
                         :from_month => education.try(:start_date).try(:month), :from_year => education.try(:start_date).try(:year),
                         :to_month => education.try(:end_date).try(:month), :to_year => education.try(:end_date).try(:year),
                         :linkedin_id => education.try(:id))
        SchoolRating.new.first_or_create(education.school_name)
        CourseRating.new.first_or_create(education.degree)
      end
    end
  end
end
