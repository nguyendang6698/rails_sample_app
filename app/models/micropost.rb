class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence:true, length: { maximum: 140}
  validate :picture_size

  private

    # Validate the size of an uploader picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture_size, "should be less than 5MB")
      end
    end
end
