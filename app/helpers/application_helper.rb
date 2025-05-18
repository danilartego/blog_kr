# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def pagination(obj)
    raw(pagy_bootstrap_nav(obj)) if obj.pages > 1
  end

  def full_title(page_title = '')
    base_title = 'AskIt'
    if page_title.present?
      "#{page_title} | #{base_title}"
    else
      base_title
    end
  end
end
