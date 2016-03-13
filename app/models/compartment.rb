class Compartment < ActiveRecord::Base

	belongs_to :cage
  has_one    :rabbit, dependent: :restrict_with_error, as: :container

  scope :busy,  -> { where(id: Rabbit.where.not(container_id: nil).pluck(:container_id)) }
  scope :empty, -> { where.not(id: Compartment.busy.pluck(:id)) }

  before_save :set_code

  delegate :last_weight, :age, to: :rabbit, prefix: true

  def empty?
    rabbit.nil?
  end

  def busy?
    rabbit.present?
  end

  def list_item_heading
    if self.rabbit
      self.rabbit.list_item_heading
    else
      "Vuota"
    end
  end

  def list_item_text
    if self.rabbit
      self.rabbit.list_item_text
    else
      ""
    end
  end

  def set_code
    return if cage.nil? || code.present?

    if cage.compartments.size > 0
      self.code = cage.compartments.last.try(:code).try(:next)
    else
      self.code = 1
    end
  end


  def move rabbit
    wanna_be_rabbit                = rabbit.becomes(FatteningRabbit)
    wanna_be_rabbit.type           = FatteningRabbit.to_s
    wanna_be_rabbit.container_type = "Compartment"
    wanna_be_rabbit.container_id   = self.id
    wanna_be_rabbit.save
  end


end
