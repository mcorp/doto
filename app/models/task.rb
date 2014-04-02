class Task < ActiveRecord::Base
  ## validations
  validates :title, presence: true
  validates :user,  presence: true

  ## associations
  belongs_to :user
end
