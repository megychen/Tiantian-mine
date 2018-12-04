module MessagesHelper
  def recipients_options(chosen_recipient = nil)
    puts params[:to]
    options_for_select(User.all.map { |user| [user.email, user.id] })
    if params[:to].present?
      user = User.where(id: params[:to])
      options_for_select(user.map { |user| [user.email, user.id] })
    else
      users = User.where(is_admin: true)
      options_for_select(users.map { |user| [user.email, user.id] })
    end
  end
end
