# frozen_string_literal: true

module ApplicationHelper
  def user_initials(user: nil)
    first_name = user.first_name
    last_name = user.last_name

    return 'NA' if first_name.empty? && last_name.empty?

    "#{first_name.first}#{last_name.first}"
  end
end
