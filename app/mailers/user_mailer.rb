class UserMailer < ApplicationMailer
  def invite_user(email, family_group)
    @family_group = family_group
    mail(to: email, subject: "Convite para participar do grupo familiar")
  end
end
