class AddColumnIconImageToAchievementCategories < ActiveRecord::Migration
  def change
    add_column :achievement_categories, :icon_image, :string, :default => "increased-roi.png"
  end
end
