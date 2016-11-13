class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :thoughts

  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true

  def published_today?
    thoughts.where('created_at >= ?', DateTime.current.beginning_of_day).count > 0
  end

end
