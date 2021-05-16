class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookings

  def user_data(token)
    {
      id: id,
      name: name,
      phone: phone,
      email: email,
      address: address,
      admin: admin,
      token: token,
    }
  end
end
