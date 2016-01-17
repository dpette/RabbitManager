class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :farms

  before_save :build_default_farm

  def build_default_farm
    if self.farms.empty?
      self.farms.new(name: "default")
    end
  end
end
