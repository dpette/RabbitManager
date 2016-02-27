class MotherRabbit < Rabbit

  validates :gender,     inclusion: { in: %w(female) }, allow_nil: false


  def position
    "Madre per #{self.cage.code}"
  end

  def giving_birth size, birth_date = Date.today
    (1..size).each do |c|
      Rabbit.create(
        container_type: self.container_type,
        container_id:   self.container_id,
        mother_id: self.id,
        father_id: self.conceptioner_id,
        birth_date: birth_date,
        type: "BabyRabbit"
      )
    end

    self.update_attributes(
      conceptioner_id: nil,
      conceptioned_on: nil
    )
  end

  def mother?
    true
  end

  def make_conception conceptioner = nil, conceptioned_on = Date.today
    self.update_attributes(
      conceptioner_id: conceptioner.try(:id),
      conceptioned_on: conceptioned_on
    )
  end

  def pregnant?
    conceptioned_on.present?
  end

end
