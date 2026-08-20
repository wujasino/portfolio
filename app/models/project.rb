class Project < ApplicationRecord
  serialize :stack, coder: JSON

  default_scope { order(:position, :id) }
end
