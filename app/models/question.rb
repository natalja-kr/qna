class Question < ActiveRecord::Base
  validates :title, :body, presence: true
  #validates_length_of :title, minimum: 15, maximum: 200
  belongs_to :user
end
