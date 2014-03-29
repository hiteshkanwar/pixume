require "open-uri"

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :role, :phone, :position, :profile_image, :summary, :video_url, :company_id, :company_name, :resume
  belongs_to :company
  # attr_accessible :title, :body
  has_many :requestors, :dependent => :destroy
  has_many :resources, :dependent => :destroy
  has_many :authentications, :dependent => :destroy
  has_many :experiences, :dependent => :destroy
  has_many :skill_sets, :dependent => :destroy
  has_many :educations, :dependent => :destroy
  has_many :achievements, :dependent => :destroy
  has_many :resume_files, :dependent => :destroy
  has_many :user_location, :dependent => :destroy
  has_many :job_postings, :dependent => :destroy #1.0
  has_many :job_applications, :dependent => :destroy # 1.0

  has_attached_file :profile_image, :styles => {:thumb => "87x87"},
                    
                    :default_url => "/assets/images/profile.png",
                    :url => "/assets/users/:id/:style/:basename.:extension",
                    :storage => :s3,
                    :bucket => 'pixsume',
                    :s3_credentials => {
                    :access_key_id => 'AKIAIEZOHCBENVLU5EFA',
                    :secret_access_key => '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'
                    }
  

  validates :name, :presence => true
  @@sort_user = ["Name","Social Rating","Current Company","Salary"]



  cattr_accessor :sort_user
  searchable :auto_index => true, :auto_remove => true do
    text :name
    text :position
    text :email
    text :summary

    # experiences
    text :company_name do
      experiences.map(&:company_name)
    end

    text :designation do
      experiences.map(&:designation)
    end

    text :experience_duration do
      experiences.map(&:duration)
    end

    text :experience_cit do
      experiences.map(&:city)
    end

    text :experience_country do
      experiences.map(&:country)
    end

    # skillsets
    text :skillset_name do
      skill_sets.map(&:name)
    end

    text :skillset_category do
      skill_sets.map(&:category)
    end

    text :skillset_expertise_level do
      skill_sets.map(&:expertise_level)
    end

    # educations
    text :education_course do
      educations.map(&:course)
    end

    text :education_institute do
      educations.map(&:institute)
    end

    text :education_location do
      educations.map(&:location)
    end

    text :education_location do
      educations.map(&:location)
    end

    # achievements

    text :achievement_title do
      achievements.map(&:title)
    end

    text :achievement_description do
      achievements.map(&:description)
    end

  end

  def create_authentication_from_omniauth(omniauth)
    
    self.authentications.create do |authentication|
      authentication.attribute_from_omniauth(omniauth)
    end
  # prepare_skills
  end

  def apply_omniauth(omniauth)
    self.email = omniauth['info']['email']
    self.name = omniauth['info']['first_name'] + ' ' + omniauth['info']['last_name']
    authentications.build do |authentication|
      authentication.attribute_from_omniauth(omniauth)
    end
  end

  def set_from_linkedin attribs
    profile_picture_url = attribs.delete(:profile_picture)
    self.update_attributes attribs
    unless profile_picture_url.blank?
      self.profile_image = open(profile_picture_url)
    self.save
    end
  end

  def first_name
    name.split(' ').first rescue ''
  end

  def get_social_rating
    ActiveRecord::Base.connection.select_value("SELECT ROUND( ( (num_connections * 50) + (num_recommendations * 25) + (num_groups * 25) ) / 100, 1 ) as social_rating FROM ( SELECT CASE WHEN num_connections < 100 THEN 1 WHEN num_connections >= 100 AND num_connections < 200 THEN 2 WHEN num_connections >= 200 AND num_connections < 300 THEN 3 WHEN num_connections >= 300 AND num_connections < 400 THEN 4 WHEN num_connections >= 400 THEN 5 ELSE 0 END AS num_connections, CASE WHEN num_recommendations = 1 THEN 1 WHEN num_recommendations > 1 AND num_recommendations < 5 THEN 2 WHEN num_recommendations >= 5 AND num_recommendations < 10 THEN 3
WHEN num_recommendations >= 10 AND num_recommendations < 15 THEN 4 WHEN num_recommendations >= 15 THEN 5 ELSE 0 END AS num_recommendations, CASE  WHEN num_groups < 10 THEN 1 WHEN num_groups >= 10 AND num_groups < 20 THEN 2 WHEN num_groups >= 20 AND num_groups < 30 THEN 3 WHEN num_groups >= 30 AND num_groups < 40 THEN 4 WHEN num_groups >= 40 THEN 5 ELSE 0 END AS num_groups,
CASE WHEN num_posts_per_month = 1 THEN 1 WHEN num_posts_per_month > 1 AND num_posts_per_month < 5 THEN 2 WHEN num_posts_per_month >= 5 AND num_posts_per_month < 10 THEN 3 WHEN num_posts_per_month >= 10 AND num_posts_per_month < 20 THEN 4
WHEN num_posts_per_month >= 20 THEN 5 ELSE 0 END AS num_posts_per_month FROM ratings WHERE user_id = #{id} ) AS X;");
  end

  def get_course_score
    ActiveRecord::Base.connection.select_value("SELECT AVG(IFNULL(score, 1)) AS course_score FROM educations e INNER JOIN course_ratings r ON e.course = r.name WHERE e.user_id = #{id};");
  end

  def get_school_score
    ActiveRecord::Base.connection.select_value("SELECT AVG(IFNULL(score, 1)) AS school_score FROM educations e INNER JOIN school_ratings r ON e.institute = r.name WHERE e.user_id = #{id};");
  end

  def get_exp_score
    ActiveRecord::Base.connection.select_value("SELECT CASE WHEN totalExpMonths = 0 THEN 1 WHEN totalExpMonths >= 1 AND totalExpMonths < 36 THEN 2 WHEN totalExpMonths >= 36 AND totalExpMonths < 60 THEN 3 WHEN totalExpMonths >= 60 AND totalExpMonths < 120 THEN 4 WHEN totalExpMonths >= 120 THEN 5 END as exp_score FROM ( SELECT SUM(( ( ( to_year - from_year ) + 1 ) * 12 ) - ( from_month - 1 ) - ( 12 - to_month )) AS totalExpMonths FROM ( SELECT CASE WHEN from_month = 0 THEN 1 ELSE from_month END as from_month, from_year, CASE WHEN is_current = 1 THEN MONTH(CURDATE()) WHEN to_month = 0 THEN 12 ELSE to_month END as to_month, CASE WHEN is_current = 1 THEN YEAR(CURDATE()) ELSE to_year END as to_year, is_current FROM ( SELECT *, (to_month + to_year + is_current) AS filter FROM ( SELECT CASE WHEN from_month = '' THEN 0 ELSE from_month END AS from_month, CASE WHEN from_year = '' THEN 0 ELSE from_year END AS from_year, CASE WHEN to_month = '' THEN 0 ELSE to_month END AS to_month, CASE WHEN to_year = '' THEN 0 ELSE to_year END AS to_year, is_current FROM experiences WHERE user_id = #{id} ) AS D WHERE from_year != 0 ) AS C WHERE filter != 0 ) AS B ) AS A;");
  end

end


