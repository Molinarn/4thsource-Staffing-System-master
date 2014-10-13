# == Schema Information
# Schema version: 20120410173410
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)     
#  email              :string(255)     
#  created_at         :datetime        
#  updated_at         :datetime        
#  encrypted_password :string(255)     
#  salt               :string(255)     
#

class User < ActiveRecord::Base
  self.per_page = 10

  attr_accessor   :password
  attr_accessible :avatar,
                  :first_name,
                  :middle_name,
                  :last_name,
                  :second_last_name,
                  :gender,
                  :birthday, 
                  :email, 
                  :password, 
                  :password_confirmation, 
                  :change_password_flag,
                  :address,
                  :city,
                  :zip_code,
                  :country,
                  :home_phone,
                  :cell_phone,
                  :office_phone
               
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
  has_one         :resume,             :dependent => :destroy 
  
  has_attached_file :avatar, :styles => { :medium => "300x300#", :thumb => "40x40#" },
                             :default_url => "/images/4thsource_avatar.jpg"
  
  accepts_nested_attributes_for :resume
  
  acts_as_ferret :fields => ['name', 'email']

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  phone_regex = /\A[0-9]{10}\Z/
  password_regex = /^(?=.{6,12})(?=.*[a-zA-Z])(?=.*\d)(?=.*[\!\#\$\%\&\? \"])$/

  validates :first_name,      :presence => true,
                              :length   => { :maximum => 50 }
  validates :middle_name,     :presence => true,
                              :length   => { :maximum => 50 }
  validates :first_last_name, :presence => true,
                              :length   => { :maximum => 50 }
  validates :second_last_name,:presence => true,
                              :length   => { :maximum => 50 }
  validates :email,           :presence => true,
                              :format   => { :with => email_regex },
                              :uniqueness => { :case_sensitive => false }
  validates :password,        :presence => true,
                              :confirmation => true,
                              :format   => { :with => password_regex },
                              :uniqueness => { :case_sensitive => true },
                              :length   => { :minimum => 6, :maximum => 12 }
  validates :password_confirmation, :presence => true,
                              :confirmation => true,
                              :format   => { :with => password_regex },
                              :uniqueness => { :case_sensitive => true },
                              :length   => { :minimum => 6, :maximum => 12 }
  validates :address,         :presence => true
  validates :city,            :presence => true
  
  validates :gender,          :inclusion => { :in => %w(M F),
                              :message => "is invalid" }
      
  validates :zip_code,        :length => { :minimum => 5 },
                              :numericality => { :only_integer => true }
  validates :home_phone,      :format => { :with => phone_regex },
                              :allow_blank => true,
                              :allow_nil => true
  validates :cell_phone,      :format => { :with => phone_regex },
                              :allow_blank => true,
                              :allow_nil => true
  validates :office_phone,    :format => { :with => phone_regex },
                              :allow_blank => true,
                              :allow_nil => true

  before_save :encrypt_password
  
  def validate
    if country == '0'
      errors.add_to_base("Country is invalid")
    end
    if password == ''
      errors.add_to_base("Password cannot be empty")
    end
  end
  
  def feed
    #Micropost.where("user_id = ?", id)
    #Micropost.from_users_followed_by(self)
  end

  def is_follow?(follow_user)
    follow = Following.where("follower_id = ? AND followed_user = ?", id, follow_user)
     
    if follow.empty?
     false
    else
      true
    end 
 end

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    if user.nil?
      nil
    elsif user.has_password?(submitted_password)
      user
    end
  end

  def self.authenticate_with_salt(id, cookie_salt) 
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
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
end

WillPaginate.per_page = 10
