class OrganizationMailer < ActionMailer::Base
  default from: "support@barbershoplabs.com"

  def welcome_email(organization, owner)
    @organization = organization
    @owner = owner

    mail(to: @owner.email, subject: "Welcome to Simple Status")
  end
end
