class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :climb_logs, dependent: :destroy
  has_many :climb_sessions

  def stats
    @stats ||= User::Stats.new(self)
  end
end
