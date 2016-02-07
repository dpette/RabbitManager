class Compartment < ActiveRecord::Base

	belongs_to :cage
  has_one    :rabbit, dependent: :restrict_with_error, as: :container

  scope :busy, -> { where(id: Rabbit.where.not(container_id: nil).pluck(:container_id)) }

  before_save :set_code

  delegate :last_weight, :age, to: :rabbit, prefix: true

  def empty?
    rabbit.nil?
  end

  def busy?
    rabbit.present?
  end

  def set_code
    return if cage.nil? || code.present?

    if cage.compartments.size > 0
      self.code = cage.compartments.last.try(:code).try(:next)
    else
      self.code = 1
    end
  end


end
