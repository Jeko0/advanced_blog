class UserMailer < Devise::Mailer
  def approve_post(user_id)
    @user = User.find(user_id)

    mail(   :to      => @user.email,
            :subject => "post appoval"
    ) do |format|
      format.html
    end
  end
end