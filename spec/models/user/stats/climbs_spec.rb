require 'rails_helper'

RSpec.describe User::Stats::Climbs, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let(:subject) { User::Stats::Climbs.new(user) }
  before(:each) {
    FactoryBot.create(:climb_log, :yesterday, user: user)
    FactoryBot.create(:climb_log, :yesterday, user: user)
    FactoryBot.create(:climb_log, date: 40.days.ago, user: user)
  }

  context 'last 30 days' do
    it 'returns the number of climbs' do
      expect(subject.last_30d_count).to eq(2)
    end
    it 'returns the increase' do
      expect(subject.increased_by).to eq(1)
    end
    it 'returns the average per day' do
      expect(subject.average_per_day).to eq(2.0)
    end
    it 'returns the average per day increase ' do
      expect(subject.average_per_day_increase_by).to eq(1.0)
    end
  end
end
