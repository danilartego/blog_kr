class AnswerDecorator < Draper::Decorator
  delegate_all

  def formatted_created_at
    created_at.strftime("%B %d, %Y at %H:%M")
  end
end
