module ApplicationHelper
  def full_title(page_title = '', admin = false)
    base_title = if admin
                   'Want Movies(管理画面)'
                 else
                   'Want Movies'
                 end
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

  def active(controller_name)
    return 'active' if controller_name == params[:controller]
  end
end
