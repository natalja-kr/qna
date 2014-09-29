class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates_length_of :name, minimum: 3, maximum: 30
  has_many :questions
end
