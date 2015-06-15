class Profile < ActiveRecord::Base
  belongs_to :user
  has_attached_file :avatar,
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :default_url => ActionController::Base.helpers.asset_path('avatar_missing.png')
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  delegate :name, :name=, :email, :email=, :to => :user

  accepts_nested_attributes_for :user, :allow_destroy => true
end
