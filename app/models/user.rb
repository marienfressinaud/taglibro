class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :thoughts

  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true

  def published_today?
    published_on(DateTime.current).count > 0
  end

  def published_on(date)
    thoughts.where('? <= created_at AND created_at <= ?', date.beginning_of_day, date.end_of_day)
  end

end
