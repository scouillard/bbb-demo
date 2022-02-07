# frozen_string_literal: true

class Recording < ApplicationRecord
  belongs_to :meeting

  validates :recording_id, uniqueness: true
end
