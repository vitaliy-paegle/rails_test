class Race < ApplicationRecord
  # has_and_belongs_to_many :racers
  validates :name, presence: true, length: {minimum: 5, maximum: 10}
  validates :member_one, presence: true
  validates :member_two, presence: true
end