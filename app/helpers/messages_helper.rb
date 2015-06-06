module MessagesHelper
  def reciver_options(chosen_reciver = nil)
    s = ''
    User.all.each do |user|
      s << "<option value='#{user.id}'  #{'selected' if user == chosen_reciver}>#{user.name}</option>"
    end
    s.html_safe
  end
end
