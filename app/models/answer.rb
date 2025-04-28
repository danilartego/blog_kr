class Answer < ApplicationRecord
  has_many_attached :images
  has_many_attached :files

  belongs_to :question

  validates :body, presence: true, length: { minimum: 10 }

  def formatted_created_at
    created_at.strftime("%B %d, %Y at %H:%M")
  end
end
