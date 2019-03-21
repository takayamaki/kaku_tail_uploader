# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("creator")
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  enum role: [:creator, :staff, :organizer, :admin], _suffix: :role
  validates :name, presence: true
  has_one :uploaded_file
  scope :role_by, ->(role) {where(role: role)}
  paginates_per 20

  def staff?
    ['admin', 'organizer', 'staff'].include? role
  end

  def upgrade_role
    update! role:([role_before_type_cast + 1, 3].min)
  end

  def downgrade_role
    update! role: ([role_before_type_cast - 1, 0].max)
  end

  def display_name
    return email if name.empty?
    name
  end
end
