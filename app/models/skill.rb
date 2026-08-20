class Skill < ApplicationRecord
  default_scope { order(:category, :position, :id) }

  validates :category, presence: true
  validates :name, presence: true, uniqueness: { scope: :category }
end
