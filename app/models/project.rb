class Project < ApplicationRecord
  serialize :stack, coder: JSON

  default_scope { order(:position, :id) }

  validates :name, presence: true
  validates :tagline, presence: true
  validates :description, presence: true
  validates :url, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }, allow_blank: true
  validates :repo, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }, allow_blank: true

  before_validation { self.stack = [] if stack.nil? }

  def stack_list
    Array(stack).join(", ")
  end

  def stack_list=(value)
    self.stack = value.to_s.split(",").map(&:strip).reject(&:blank?)
  end
end
