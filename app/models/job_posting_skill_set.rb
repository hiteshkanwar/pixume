class JobPostingSkillSet < ActiveRecord::Base
  attr_accessible :job_posting_id, :name

  belongs_to :job_posting

  validates :name, :presence => true
  validates :name, :uniqueness => {:scope => [:job_posting_id]}, :length => { :maximum => 50 }

  def first_or_create(job_posting_id, skillset)
    JobPostingSkillSet.where(:job_posting_id => job_posting_id).where(:name => skillset).first_or_create(:job_posting_id => job_posting_id, :name => skillset);
  end
end
