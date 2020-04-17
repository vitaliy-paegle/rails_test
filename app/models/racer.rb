class Racer < ApplicationRecord
    # has_and_belongs_to_many :races
    validates :name, presence: true, length: {minimum: 5, maximum: 10}
    validates :number, presence: true
end
