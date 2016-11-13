class Thought < ApplicationRecord

  belongs_to :user

  validates :user, presence: true
  validate :user_publish_once_a_day_only

private

  def user_publish_once_a_day_only
    if user.published_today?
      errors.add(:base, 'Thought can be published once a day only')
    end
  end

end
