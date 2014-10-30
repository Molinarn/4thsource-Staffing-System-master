
class Candidate < ActiveRecord::Base
  
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  PHONE_REGEX = /\(\d{3}\) \d{3}-\d{4}/
  # PHONE_REGEX = /\A[0-9]{10}\Z/  
  
  TYPE = CandidatesInterviewFilter::TYPE

  @flag = true

  self.per_page = 10

  attr_accessor   :password
  attr_accessor   :role
  #attr_accessor   :location

  attr_accessible :address, :id,
 
  :address1, 
  :avatar,
  :avatar_file_name, 
  :birthdate,
  :cell_phone, 
  :change_password_flag, 
  :city,
  :comments, 
  :company, 
  :country,
  :created_at, 
  :current_salary, 
  :currently_employed, 
  :marital_status,
  :degree, 
  :email, 
  :first_last_name, 
  :first_name, 
  :gender,
  :graduation_year, 
  :has_passport, 
  :has_visa, 
  :home_phone, 
  :is_willing_to_relocate, 
  :is_willing_to_travel, 
  :middle_name, 
  #:mobile, 
  #:name, 
  :neighborhood, 
  :office_phone, 
  #:office_telephone, 
  :passport_expiration_year, 
  :position, 
  :salary_expectancy, 
  :second_last_name, 
  :status_id, 
  :technology_id, 
  #:telephone, 
  :university, 
  :updated_at, 
  :updated_by, 
  :visa_expiration_year, 
  :zip_code,
  :password,
  :password_confirmation,
  :change_password_flag,
  :admin_flag,
  :currently_in_4Source,
  :recruited_at,
  :started_at,
  :office_id,
  :email_alternate_1,
  :email_alternate_2,
  :email_alternate_3,
  :referral_type,
  :location,
  :availability_Immediate,
  :time_blocks,
  :time_periods

  #This allow many models to associate with one (project/admin_user)
  belongs_to      :applicant,          :polymorphic => true

  has_many        :microposts,         :dependent => :destroy   
  has_many        :followings,         :foreign_key => "follower_id",
                                       :dependent => :destroy                            
  has_many        :reverse_followings, :foreign_key => "followed_id",
                                       :class_name => "Following",
                                       :dependent => :destroy
  has_many        :followers,          :through => :reverse_followings, 
                                       :source => :follower
  has_many        :following,          :through => :followings, 
                                       :source => :followed

  #has_and_belongs_to_many              :projects, :foreign_key => "candidate_id"
                                       #:dependent => :destroy

  # Added
  #has_many        :projects_roles,     :through => :projects,
                                       #:dependent => :destroy
  #has_many        :projects, :through => :projects_roles

  #belongs_to      :project

  has_many        :projects,  :dependent => :destroy
  #accepts_nested_attributes_for :projects

  #has_many        :projects_roles, :through => :projects

  has_one         :resume,             :dependent => :destroy 

  has_many        :candidate_certifications,      :dependent => :destroy
  has_many        :candidate_trainings,      :dependent => :destroy

  has_many        :candidate_languages, :dependent => :destroy
  has_many        :candidate_education, :dependent => :destroy



  has_one         :candidate_prof_summary,  :dependent => :destroy
  has_many        :candidates_interviews,   :foreign_key => "candidate_id",
                                            :dependent => :destroy

  has_many        :candidates_profiles,      :dependent => :destroy                                            

  has_many        :admin_users, :dependent => :destroy
  #:dependent => :destroy

  #accepts_nested_attributes_for :admin_users

  has_one         :interviewer_user, :dependent => :destroy
  
  has_attached_file :avatar, :styles => { :medium => "300x300#", :thumb => "40x40#" },
                             :default_url => "/images/4thsource_avatar.jpg",
                             :url => "/system/users/avatars/:id/:basename.:extension"
  
  
  acts_as_ferret :fields => ['name', 'email']

#  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
#  phone_regex = /\A[0-9]{10}\Z/  

  #validates :name,            :presence => true,
  #                            :length   => { :maximum => 50 }
  validates :first_name,       :presence => true,
                               :length   => { :maximum => 50 }

  validates :first_last_name,       :presence => true,
                              :length   => { :maximum => 50 }
  #validates :second_last_name,:presence => true,
  #                            :length   => { :maximum => 50 }
  validates :email,           :presence => true,
                              :format   => { :with => EMAIL_REGEX },
                              :uniqueness => { :case_sensitive => false }
  validates :password,        :confirmation => true,                              
                              :presence => true,
                              :on => :create
  validates :password,        :confirmation => true,                              
                              #:on => :update, allow_blank: true
							                :on => :update, :allow_blank => true
  validates :password_confirmation, :confirmation => true,
                                    :presence => true,
                                    :on => :create
  validates :password_confirmation, :confirmation => true,
                                    #:on => :update, allow_blank: true
									                  :on => :update, :allow_blank => true
  #validates :address,         :presence => true
  #validates :city,            :presence => true
  
  #validates :gender,          :inclusion => { :in => %w(M F),
  #                            :message => "is invalid" }
  validates :passport_expiration_year,     :length => { :minimum => 4 }, :allow_nil => true,
                                           :numericality => { :only_integer => true } 
  validates :visa_expiration_year,     :length => { :minimum => 4 }, :allow_nil => true,
                                       :numericality => { :only_integer => true }
  validates :zip_code,        :length => { :minimum => 5 }, :allow_nil => true,
                              :numericality => { :only_integer => true }
  validates :home_phone,      :format => { :with => PHONE_REGEX },
                              :allow_blank => true,
                              :allow_nil => true,
#                              :numericality => { :only_integer => true },
                              :length => { :minimum => 10 }
  validates :cell_phone,      :format => { :with => PHONE_REGEX },
                              :allow_blank => true,
                              :allow_nil => true,
#                              :numericality => { :only_integer => true },
                              :length => { :minimum => 10 }
  validates :office_phone,    :format => { :with => PHONE_REGEX },
                              :allow_blank => true,
                              :allow_nil => true,
#                              :numericality => { :only_integer => true },
                              :length => { :minimum => 10 }

  before_save :encrypt_password
  # after_initialize :build_prerequisites

  # :build_default_project, :build_default_education

  def actual_name
    "#{first_name} #{first_last_name}"
  end

  def avatarurl     
    (avatar.exists?) ? avatar.url(:thumb): "/images/4thsource_avatar.jpg"  
  end

  def validate
    if country == '0'
      errors.add_to_base("Country is invalid")
    end
  end
  
  def feed
     Micropost.from_candidates_followed_by(self)
  end

  def unread
    Micropost.select("*").where("is_active = 1 AND checked != 1 AND candidate_id = ?", self.id).size
  end

  def followers
    Following.select("followed_id").where("follower_id = ?", id)
  end

  def check_microposts

    microposts_list = Micropost.select("*").where("is_active = 1 AND checked != 1 AND candidate_id = ?", self.id)
  
    if microposts_list.size > 0
      microposts_list.update_all "checked = 1"
    end
  end

  def is_follow?(follow_user_id)
    if follow_user_id.nil?   
      false
    else
      !Following.where("follower_id = ? AND followed_id = ?", id, follow_user_id).empty?
    end 
  end

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
 
  def have_interviews?
   !candidates_interviews.empty? 
  end

  def self.authenticate(email, submitted_password)
    #add self before find

    puts "\ncandidate#authenticate".green

    #puts "#{email}".blue
    #puts "#{submitted_password}".blue

    user = find_by_email(email)

    rv = [user,"nil"]

    #puts ["\nuser: ".yellow, "#{user.id}".red]
    #puts ["pwd: ".yellow, "#{submitted_password}".red]

    if user.nil?

      puts "\nuser.nil".red

      rv[1] = "nil" #nil

    elsif user.has_password?(submitted_password)

      rv[1] = "valid"

    ## Added
    else

      rv[1] = "wrong"

    end

  end

  def self.authenticate_with_salt(id, cookie_salt)

    #puts "\ncandidate#authenticate_with_salt > user=nil".red

    #add self before find
    user = find_by_id(id)

    if user != nil

      #puts "\ncandidate#authenticate_with_salt".magenta

      #puts ["\nuser.id: ".cyan, "#{user.id}".red]
      #puts ["cookie: ".cyan, "#{cookie_salt}".red]

      #(user && user.salt == cookie_salt) ? user : nil

      if user.salt == cookie_salt

        puts ["\nauthenticated?: ".yellow, "#{true}".red]

      end

    end

    user

  end
 
  def current_salary=(num)
    self[:current_salary] = num.to_s.scan(/\b-?[\d]+/).join.to_f
  end
  
  def salary_expectancy=(num)
    self[:salary_expectancy] = num.to_s.scan(/\b-?[\d]+/).join.to_f
  end

  def outOfInterviewerGroup?(interviewer)
    InterviewerUser.where(:candidate_id => id, :interviewer_id => interviewer.id).empty?
  end


# Building the default user profile related code


  def build_default_project

    #falta el link de candidate > project
    if self.projects.empty?

    #puts "\n#{self.projects}".green

    #if self.projects === nil

      #project_attrs =
      #{
        name = 'Default project'
        summary = 'This is the default project for this candidate.'
      #}

      #project = self.projects.build(project_attrs)

      #puts ["\ncreate_project: ".yellow, "#{Project.new(:name => name,:summary => summary).valid?}".red]

      #project = @Project.create(:name => name,:summary => summary)

      project = self.projects.new
      project.name = name
      project.summary = summary
      #project.candidate_id = self.id

      puts ["\nbuild_default_project: ".yellow, "#{project.save}".red]

      #save fails
      #puts ["\n#{project.name}".green,"#{project.summary}".blue]
      #build_default_role_in_project(project,build_default_role)

      #puts "\nself > #{self.reflections.keys}".blue
      #puts "\nself.foreign_key > #{self.reflections[:projects].foreign_key}".blue

      build_default_role_in_project(project)

    end
  end

  def build_default_role_in_project(project)
 #def build_default_role_in_project(project,role)

    #default_role_id = Role.first.id
    #role_attrs =
    #{
       #role_id = default_role_id,
       #project_id = project.id,
       #date_in = DateTime.now,
       #date_out = DateTime.now
    #}
    #projects_role = project.projects_roles.build(role_attrs)
    projects_role = project.projects_roles.new

    #role = Roles.new
    #role.name = "Default Role"

    #puts ["\nrole.save: ".yellow, "#{role.save}".red]

    #projects_role.role_id = role.id

    puts ["\nbuild_default_projects_role: ".yellow, "#{projects_role.save}".red]

    #puts "\nproject > #{project.reflections.keys}".blue

    build_default_role(projects_role)
    build_default_projects_tag(projects_role)

  end

  def build_default_role(projects_role)

    #puts "\nprojects_role > #{projects_role.reflections.keys}".blue
    #puts "\nprojects_role > #{projects_role.reflections[role].foreign_key}".blue

    #puts "\nprojects_role.projectRole: #{projects_role.projectRole}".magenta

    #role = Role.new
    #role.projects_roles = projects_role
    role = projects_role.roles.new

    #role = ProjectsRole.roles.new
    role.name = "Default role"
    role.date_in = DateTime.now
    role.date_out = DateTime.now

    #role = Role.new

    puts ["\nbuild_default_role: ".yellow, "#{role.save}".red]

    #puts "\nprojects_role > #{projects_role.reflections.keys}".blue
    #puts "\nprojects_role > #{projects_role.reflections[role].foreign_key}".blue

    #puts "\nrole > #{role.reflections.keys}".blue

    #pr = role.projects_roles.new

    #puts ["\nbuild_default_role: ".yellow, "#{pr.save}".red]

  end

  def build_default_projects_tag(projects_role)

    projtag = projects_role.projects_tags.new

    puts ["\nbuild_default_projects_tag: ".yellow, "#{projtag.save}".red]

  end

  def build_default_education
    #edu_degree = EducDegree.first.id
    #education_attrs =
    #{
      #educ_degree_id=> edu_degree,
      #candidate_id= self.id,
      #title= 'A title',
      #degree= 'A degree',
      #university='Life'
    #}
    #edu = self.candidate_education.build(education_attrs)
    #edu.save

    edu = self.candidate_education.new
    #edu.candidate_id = self.id
    edu.title = 'n/a'
    edu.university = 'n/a'

    puts ["\nbuild_default_education".yellow , "#{edu.save}".red]

    build_default_edu_degree(edu)

  end

  def build_default_edu_degree(education)

    degree = education.educ_degrees.new
    degree.name = "Default degree"

    puts ["\nbuild_default_edu_degree".yellow , "#{degree.save}".red]

  end

  def build_default_admin_users

    #puts ["\nself: ".magenta, "#{self.id}".green]

    #if self.admin_users != nil
    if false

      puts "\nadmin_user = nil > destroy".red

      #self.destroy
      #@flag = false

    else

      #puts "\nadmin_user ~= nil".cyan

      admin_user = self.admin_users.new

      #admin = self.admin_users.create
      #admin = self.AdminUser.new
      #admin = self.admin_user.new

      puts ["\nbuild_default_admin_user".yellow , "#{admin_user.save}".red]

    end

  end

  def build_prerequisites
    build_default_admin_users
    build_default_project
    build_default_education
  end

  def build_default_candidate_profile      

    build_prerequisites

    puts "\nbuild_prerequisites".green

    #profile_data = ""
    #self.projects.includes(:projects_roles).each do |project|
      #profile_data << "{#project:#{project.id}#}"
      #project.projects_roles.includes(:roles).each do |role|
        #profile_data << "{#role:#{project.id}/#{role.roles.id}#}"
        #role.tags1.includes(:tags).each do |t1|
          #profile_data << "{#tag:#{project.id}/#{role.roles.id}/#{t1.tags.id}#}"
        #end
        #role.tags2.includes(:tags).each do |t2|
          #profile_data << "{#tag:#{project.id}/#{role.roles.id}/#{t2.tags.id}#}"
        #end
        #role.tags3.includes(:tags).each do |t3|
          #profile_data << "{#tag:#{project.id}/#{role.roles.id}/#{t3.tags.id}#}"
          #CustomQueries.getTechnologies(t3.tags.id).each do |techs|
            #profile_data << "{#tech:#{p.id}/#{r.roles.id}/#{t3.tags.id}/#{techs[0]}'>#{techs[2]}#}"
          #end
        #end
      #end
    #end

    # The code starts here
    candidates_profile = self.candidates_profiles.new
    candidates_profile.name = "Default profile"
    candidates_profile.summary = "Default Summary"
    candidates_profile.profiledata = "Default Data"

    puts ["\ncandidate_profile: ".yellow, "#{candidates_profile.save}".red]

    #if self.admin_user == nil
      #self.destroy
      #puts "\nadmin_user == nil > DESTROY".red
    #end

    #candidates_profile.save

    # binding.pry
  end  



  private
    def encrypt_password
      self.salt = make_salt if new_record?
      if password != change_password_flag && password!=""
        self.encrypted_password = encrypt(password)
      end
    end

    def encrypt(string) 
      secure_hash("#{salt}--#{string}")
    end

    def make_salt 
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string) 
      Digest::SHA2.hexdigest(string)
    end
	
  # Building the default user profile related code
    #def build_default_project
	  #if self.projects.empty?
      #if self.projects.empty?
       # project_attrs = {name=> 'Default project', summary=> 'This is the dafault project for this candidate.'}
        #project = self.projects.build(project_attrs)
      #end
    #end

  #def build_default_education
   # if self.candidate_education.nil?
     # edu_degree = EducDegree.first.id
    #education_attrs =
    #{
      #educ_degree_id=> edu_degree,
      #candidate_id=> self.id,
      #title=> 'A title',
      #degree=> 'A degree',
      #university=>'Life'
    #}
    #edu = self.candidate_education.build(education_attrs)
    #edu.save
    #end
  #end

end
