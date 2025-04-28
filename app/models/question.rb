class Question < ApplicationRecord
  has_many_attached :images
  has_many_attached :files


  has_many :answers, dependent: :destroy

  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { minimum: 10 }

  def formatted_created_at
    created_at.strftime("%B %d, %Y at %H:%M")
  end
end
