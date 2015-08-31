require 'rails_helper'

RSpec.describe VoteNotifier do

  let(:voter)   {  User.create(uid:  'null|678910', name: 'Alice', notify_me: 'true'  )}
  let(:movie)   {  Movie.create(title: 'High Fidelity', description: 'What came first, the music or the misery?', user: creator)}

  describe "#perform" do

  context "when a user has notify me on" do
    let(:creator) {  User.create(uid:  'null|12345', name: 'Bob', notify_me: 'true', email: 'bob@example.com' ) }

    it "sends an email for a like" do
      vn = VoteNotifier.new(voter, creator, movie, :like)
      expect{vn.perform}.to change { ActionMailer::Base.deliveries.count }.by(1)


      last_delivery = ActionMailer::Base.deliveries.last
      expect(last_delivery.subject).to eq "Great news from Movierama!"
      expect(last_delivery.to).to eq [creator.email]
      expect(last_delivery.body).to include movie.title
      expect(last_delivery.body).to include voter.name
    end

    it "sends and email for a dislike" do
      vn = VoteNotifier.new(voter, creator, movie, :hate)
      expect{vn.perform}.to change { ActionMailer::Base.deliveries.count }.by(1)

      last_delivery = ActionMailer::Base.deliveries.last
      expect(last_delivery.subject).to eq "We're sorry to tell you this..."
      expect(last_delivery.to).to eq [creator.email]
      expect(last_delivery.body).to include movie.title
      expect(last_delivery.body).to include voter.name
    end

  end

  context "when a user has notify me off" do
    let(:creator) {  User.create(uid:  'null|12345', name: 'Bob', email: 'bob@example.com'  ) }

    it "sends no email" do
      vn = VoteNotifier.new(voter, creator, movie, :like)
      expect{vn.perform}.to change { ActionMailer::Base.deliveries.count }.by(0)
    end
  end

  context "if the user has no email" do
    let(:creator) {  User.create(uid:  'null|12345', name: 'Bob', notify_me: 'true'  ) }

    it "sends no email" do
      vn = VoteNotifier.new(voter, creator, movie, :like)
      expect{vn.perform}.to change { ActionMailer::Base.deliveries.count }.by(0)
    end

  end

end


end
