class SkillSet < ActiveRecord::Base
  attr_accessible :name, :expertise_level, :expertise_level_id, :category, :user_id, :linkedin_id

  belongs_to :user
  has_many :resources

  validates :name, :presence => true
  validates :name, :uniqueness => {:scope => [:user_id]}, :length => { :maximum => 50 }
  validates :linkedin_id, :uniqueness => {:scope => [:user_id]}, :allow_nil => true
  validates :category, :length => { :maximum => 50 }
  
  @@experties_levels = ["Beginner", "Intermediate", "Advanced", "Expert"]
  cattr_accessor :experties_levels

  def self.create_from_linkedin user, skills
    unless skills.blank?
      skills.each do |skill|

        exp_level = "Advanced"
        unless skill.proficiency.blank?
          exp_level = skill.proficiency.name
        end
        exp_level_id = get_expertise_level_id(exp_level)

        SkillSet.create(:user_id => user.id, :name => skill.skill.name, :category => "", :expertise_level => exp_level, :expertise_level_id => exp_level_id, :linkedin_id => skill.id)
      end
    end
  end

  def self.get_expertise_level_id exp_level
    exp_level_id = 0

    @@experties_levels.each_with_index do|val, index|
      if val == exp_level
        exp_level_id = index + 1
      end
    end

    return exp_level_id
  end
  
end
