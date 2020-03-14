# frozen_string_literal: true

class Product < ApplicationRecord
  before_create :set_status

  validates :title, :slug, :description, :price, presence: true
  validates :price, numericality: { greather_than: 0 }

  validates :description, length: { minimum: 12, maximum: 256 }

  scope :find_by_slug, ->(slug) { find_by(slug: slug) }
  scope :active_products, -> { where(active: true) }


  private

  def set_status
    self.active ||= true
  end
end
