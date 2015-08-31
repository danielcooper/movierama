class VoteNotifier

  def initialize(from, to, movie, preference)
    @from, @to, @movie, @preference = from, to, movie, preference
  end

  def should_send?
    @to.notify_me? && !@to.email.blank?
  end

  def perform
    if should_send?
      NotificationMailer.send(:"#{@preference}_notification", @from, @to, @movie).deliver
    end
  end

end
