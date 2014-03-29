class JobPosting < ActiveRecord::Base
  attr_accessible :company_id, :country, :description, :is_public, :location, :max_years_exp, :min_years_exp, :requirements, :salary, :show_matching_profiles, :title, :user_id

  validates :title, :description, :requirements, :presence => true
  validate :min_years_exp_must_be_less_than_max_years_exp

  belongs_to :company
  belongs_to :user

  has_many :job_posting_skill_sets, :dependent => :destroy
  has_many :job_applications, :dependent => :destroy # 1.0

  def min_years_exp_must_be_less_than_max_years_exp
    if self.min_years_exp.blank? == false && self.max_years_exp.blank? == false
      if self.min_years_exp > self.max_years_exp
        errors.add(:min_years_exp, "must be less than or equal to max years exp")
      end
    end
  end
end
