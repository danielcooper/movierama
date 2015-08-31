class NotificationMailer < ActionMailer::Base
  default from: "gossip@movierama.dev"

  def like_notification(from, to, movie)
    @from, @to, @movie = from, to, movie
    mail(to: @to.email, subject: 'Great news from Movierama!')
  end

  def hate_notification(from, to, movie)
    @from, @to, @movie = from, to, movie
    mail(to: @to.email, subject: "We're sorry to tell you this...")
  end


end
