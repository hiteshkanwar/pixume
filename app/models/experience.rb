class Experience < ActiveRecord::Base
  attr_accessible :user_id, :company_name, :designation, :from_month, :from_year, :to_month, :to_year, :country, :city,
                  :description, :is_current, :linkedin_id

  belongs_to :user
  validates :company_name, :designation, :from_month, :from_year, :presence => true
  validates :to_month, :to_year, :presence => true, :if => :not_current
  validates :linkedin_id, :uniqueness => {:scope => [:user_id]}, :allow_nil => true
  
  def self.crate_from_linkedin user, positions
    unless positions.blank?
      positions.each do |position|
        Experience.create(:user_id => user.id, :company_name => position.try(:company).try(:industry), :designation => position.title,
        :from_month => position.try(:start_date).try(:month), :from_year => position.try(:start_date).try(:year),
        :to_month => position.try(:end_date).try(:month), :to_year => position.try(:end_date).try(:year),
        :is_current => position.try(:is_current), :linkedin_id => position.try(:id),
        :description => position.try(:summary))
      end
    end
  end

  def not_current
    return !is_current
  end
end
