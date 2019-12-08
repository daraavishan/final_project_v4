# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  password_digest :string
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_username  (username) UNIQUE
#

class User < ApplicationRecord
  has_secure_password

  #Validates that email is both present and unique 
  validates :username, presence: true, uniqueness: true

  has_many :user_top_artist_images
end
