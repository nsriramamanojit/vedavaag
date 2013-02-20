module ApplicationHelper
  def per_page
    select_tag :per_page, options_for_select([5, 10, 20, 50, 100], @per_page.to_i), :onchange => "if(this.value){window.location='?per_page='+this.value+'&page=#{@page}'+'&query=#{@query}'}"
  end

  def link_for_edit(path)
    link_to image_tag('/images/icons/edit.png'), path, :title => 'Edit', :class => 'tipTip', :border => 0
  end

  def link_for_show(path)
    link_to image_tag('/images/icons/show.png'), path, :title => 'View', :class => 'tipTipTop', :border => 0
  end

  def link_for_show_pop(path)
    link_to image_tag('/images/icons/show.png'), path, :title => 'View', :class => 'tipTipTop', :rel => "facebox", :border => 0
  end

  def link_for_destroy(path)
    link_to image_tag('/images/icons/delete.png'), path, :confirm => 'Are you sure, want to Delete Record?', :method => :delete, :title => 'Delete', :class => 'tipTip'
  end

  def tab_heading(heading)
    content = ""
    content << "<a href='#'>"
    content << "<div class='menu-l'>&nbsp;</div><div class='menu-c'><span>&nbsp;&nbsp;#{heading}&nbsp;&nbsp;&nbsp;</span></div>"
    content << "<div class='menu-r'>&nbsp;</div></a>"
    content.html_safe
  end

  def sub_heading(main, sub)
    "<h3>#{main}<span>&nbsp;|&nbsp;#{sub}</span></h3>".html_safe
  end

  def link_to_all(path)
    link_to content_tag(:span, "&larr; Back To List".html_safe), path, :class => 'btn-yellow'
  end
  def created_by(created_by)
    User.where(:id => created_by).first.name
  end
  def title(page_title, show_title = true)
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
  end

  def show_title?
    @show_title
  end

  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end

  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end
  def users_list(users)
    return 'No Users found' if users.blank?
    content = ''
    i = 1
    for user in users[0..15]
      content << "#{i}. " + user.name + "<br/>"
      i += 1
    end
    content << 'and more' if users.size > 16
    content.html_safe
  end
  def get_role(user)
    roles = Role.where(:id=>user.roles)
    content = ""
    for role in roles
      content << role.name.titleize
      content <<  "<br/>"
    end
    content.html_safe
  end
  def link_to_active(model, path)
    content = ''
    content << "<div id='status_#{model.id}'>"
    content << link_to(model.status ? image_tag('tick.gif') : image_tag('cross.gif'), path, :remote=>true)
    content << "</div>"
    content.html_safe
  end

  def link_to_active_pay(model, path)
    content = ''
    content << "<div id='status_pay_#{model.id}'>"
    content << link_to(model.status ? image_tag('tick.gif') : image_tag('cross.gif'), path, :remote=>true)
    content << "</div>"
    content.html_safe
  end

end
