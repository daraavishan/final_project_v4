# == Schema Information
#
# Table name: user_top_tracks_shorts
#
#  id                :integer          not null, primary key
#  track_artist      :string
#  track_preview_url :string
#  track_title       :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :integer
#

class UserTopTracksShort < ApplicationRecord
  belongs_to :user
end
