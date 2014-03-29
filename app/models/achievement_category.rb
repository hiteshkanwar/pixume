class AchievementCategory < ActiveRecord::Base
  attr_accessible :description, :is_public, :name, :icon_image
  validates :name, :presence => true, :uniqueness => true, :length => { :minimum => 2, :maximum => 50 }


  def self.get_public_categories
    @categories_array = Array.new

    @categories = where(:is_public => true ).all

    @categories.each do |category|
      @categories_array << category.try(:name)
    end

    return "[" + @categories_array.map {|str| "\"#{str}\""}.join(',') + "]"
  end

  def first_or_create(category)
    AchievementCategory.where(:name => category).first_or_create(:description => category, :is_public => false)
  end

  def self.get_icon_image category
    icon_image = "increased-roi.png"
    category = where(:name => category).first
    if !category.blank?
      icon_image = category.icon_image
    end
    return icon_image
  end
end
