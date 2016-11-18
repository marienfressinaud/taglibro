class Thought < ApplicationRecord

  belongs_to :user

  validates :user, presence: true
  validate :user_publish_once_a_day_only

  scope :created_after, -> (datetime) {
    where('? <= created_at', datetime)
  }

private

  def user_publish_once_a_day_only
    thought = user.published_on(created_at || DateTime.current).take
    if thought and thought.id != id
      errors.add(:base, 'Thought can be published once a day only')
    end
  end

end
