class Skill < ApplicationRecord
  default_scope { order(:category, :position, :id) }
end
