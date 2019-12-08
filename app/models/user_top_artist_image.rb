# == Schema Information
#
# Table name: user_top_artist_images
#
#  id         :integer          not null, primary key
#  image_url  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class UserTopArtistImage < ApplicationRecord
  belongs_to :user
end
