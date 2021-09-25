class Post < ApplicationRecord
    belongs_to :user
    belongs_to :follow
    mount_uploader :photo, PhotoUploader
    
    validates :photo,  presence: true
    validates :title, presence: true, length: { maximum: 50 }
    validates :explanation, presence: false, length: { maximum: 400 }
    
    has_many :favorites, dependent: :destroy
end
