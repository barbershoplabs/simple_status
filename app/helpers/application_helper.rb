module ApplicationHelper
  def pluralize_without_count(string, count)
    count > 1 ? string.pluralize : string
  end
end
