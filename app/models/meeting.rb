# frozen_string_literal: true

class Meeting < ApplicationRecord
  has_one :recording
end
