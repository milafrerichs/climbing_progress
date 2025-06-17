require 'rails_helper'

RSpec.describe ClimbLog, type: :model do
  let(:subject) { FactoryBot.build(:climb_log) }
  it { should belong_to(:user) }

  context 'status' do
    it 'should be Flash when number_of_tries is 1' do
      subject.tries = 1
      subject.status = "Top"
      expect(subject).not_to be_valid
    end

    it 'should be Project when number_of_tries is greater than 5' do
      subject.tries = 6
      subject.status = "Top"
      expect(subject).not_to be_valid
    end

    it 'should be Top when number_of_tries is between 2 and 5' do
      subject.tries = 2
      subject.status = "Flash"
      expect(subject).not_to be_valid
    end
  end
  context '#last_30_days' do
    it 'should return climbs from the last 30 days' do
      FactoryBot.create(:climb_log, :yesterday)
      FactoryBot.create(:climb_log, date: 40.days.ago)
      expect(ClimbLog.last_30_days.count).to eq(1)
    end
  end
end
