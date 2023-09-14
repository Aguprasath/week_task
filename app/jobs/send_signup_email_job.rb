class SendSignupEmailJob < ApplicationJob
   #include Sidekiq::job

   def perform(user)
      UserMailer.signup_confirmation(user).deliver_later
   end
end
