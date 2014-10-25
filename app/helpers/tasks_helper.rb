module TasksHelper

  def link_to_unless_current_ignore_parameters(title, link)
    link_to_unless(request.request_uri.gsub(/\?.*/, '') == url_for(link), title, link)
  end

end
