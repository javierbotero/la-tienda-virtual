module ApplicationHelper
  def flash_css_classes(type)
    case type
    when 'notice'
      'bg-success text-light'
    when 'error'
      'bg-danger text-light'
    else
      'bg-warning text-dark'
    end
  end
end
