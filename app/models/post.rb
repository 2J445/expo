class Post < ApplicationRecord
    belongs_to :user
    mount_uploader :photo, PhotoUploader
    
    validates :title, presence: true, length: { maximum: 50 }
    validates :explanation, presence: false, length: { maximum: 240 }
end
