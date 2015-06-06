class Message < ActiveRecord::Base
  belongs_to :sender, class_name: "User",  foreign_key: "sender_id"
  belongs_to :reciver, class_name: "User", foreign_key: "reciver_id"

  default_scope -> { order(created_at: :desc) }

  validates :body, presence: true, length: { maximum: 500 }
  validates :sender_id, presence: true
  validates :reciver_id, presence: true
end
