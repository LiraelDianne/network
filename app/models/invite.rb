class Invite < ActiveRecord::Base
  belongs_to :user
  belongs_to :inviter, class_name: "User"
end
