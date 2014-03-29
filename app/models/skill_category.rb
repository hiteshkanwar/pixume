class SkillCategory < ActiveRecord::Base
  attr_accessible :description, :is_public, :name

  validates :name, :presence => true, :uniqueness => true, :length => { :minimum => 2, :maximum => 50 }

  def self.get_public_categories
    @categories_array = Array.new

    @categories = SkillCategory.where(:is_public => true ).all

    @categories.each do |category|
      @categories_array << category.try(:name)
    end

    return "[" + @categories_array.map {|str| "\"#{str}\""}.join(',') + "]"
  end

  def first_or_create(category)
    SkillCategory.where(:name => category).first_or_create(:description => category, :is_public => false)
  end

end
