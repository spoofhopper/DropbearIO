# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  email                  :string
#  phone                  :string
#  address                :string
#  website                :string
#  image_url              :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  provider               :string
#  uid                    :string
#  twitter_token          :string
#  twitter_secret         :string
#


class User < ActiveRecord::Base
  has_many :groups
  has_many :contacts, through: :groups
  has_many :messages, through: :groups
  validates :name, presence: true,
                    length: { minimum: 5, maximum: 50 }


  def self.find_or_create_from_auth_hash (auth_hash)
    # look up the user or create them
    user = where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create
    user.update(
      name: auth_hash.info.name,
      email: auth_hash.info.email,
      image_url: auth_hash.info.image,
      twitter_token: auth_hash.credentials.token,
      twitter_secret: auth_hash.credentials.secret,
    )
    user
  end



  private



end
