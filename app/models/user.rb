class User < BaseModel
  include Ohm::Timestamps

  attribute :name
  attribute :notify_me
  attribute :email


  # Unique identifier for this user, in the form "{provider}|{provider-id}"
  attribute :uid
  index     :uid
  unique    :uid

  # Session token
  attribute :token
  index     :token

  # Submitted movies
  collection :movies, :Movie

  def notify_me?
    notify_me && notify_me == 'true'
  end
end
