class OrderMailer < ApplicationMailer
  def order_message(order)
    manager_email = SettingProvider.instance.value_of :manager_email
    unless ValidateEmail.valid?(manager_email)
      raise StandardError, "There is no correct manager_email."
    end
    @order = order
    mail(to: manager_email, subject: "Received a new order from #{@site_name}")
  end
end