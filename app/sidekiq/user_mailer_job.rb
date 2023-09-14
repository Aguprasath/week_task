class UserMailerJob
  include Sidekiq::Job

  def perform(user_data)
    user=User.new(user_data)
    UserMailer.signup_confirmation(user).deliver_now
  end
end
