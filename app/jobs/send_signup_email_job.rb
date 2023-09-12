class SendSignupEmailJob < ApplicationJob
  queue_as :default

   def perform(user)
     #user = User.find(user_id)
      UserMailer.signup_confirmation(user).deliver_later
    end
end
