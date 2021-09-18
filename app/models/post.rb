class Post < ApplicationRecord
    belongs_to :user
    mount_uploader :photo, PhotoUploader
    
    validates :photo,  presence: true
    validates :title, presence: true, length: { maximum: 50 }
    validates :explanation, presence: false, length: { maximum: 200 }
end
