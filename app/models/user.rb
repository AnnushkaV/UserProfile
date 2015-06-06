class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_one :profile, :class_name => 'Profile', :foreign_key => 'user_id', :dependent => :destroy
  has_many :sendmessages, :foreign_key => :sender_id, class_name: 'Message'
  has_many :recivmessages, :foreign_key => :reciver_id, class_name: 'Message'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  accepts_nested_attributes_for :profile
end
