RSpec.describe LapBuilder do
  describe '.build_from_strings' do
    let(:pilot) { build(:pilot) }
    it 'returns a valid Lap' do
      lap = described_class.build_from_strings(
        '1', '1:02.852', '44,275', '23:49:08.277', pilot
      )

      expect(lap).to be_a Lap
      expect(lap.number).to eq 1
      expect(lap.duration).to eq 62.852
      expect(lap.average_speed).to eq 44.275
      expect(lap.finish_time).to eq 85_748.277
    end
  end
end
