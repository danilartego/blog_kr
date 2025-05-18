# frozen_string_literal: true

class Answer < ApplicationRecord
  has_many_attached :images
  has_many_attached :files

  belongs_to :question

  validates :body, presence: true
end
