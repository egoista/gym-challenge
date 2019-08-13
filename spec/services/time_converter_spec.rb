RSpec.describe TimeConverter do
  describe '.minute_string_to_seconds' do
    it 'returns in seconds float' do
      expect(described_class.minute_string_to_seconds('01:00.010')).to eq 60.01
    end
  end

  describe '.hour_string_to_seconds' do
    it 'returns in seconds float' do
      expect(described_class.hour_string_to_seconds('01:01:00.010')).to eq 3660.01
    end
  end

  describe '.seconds_to_minute_string' do
    it 'returns a time string' do
      expect(described_class.seconds_to_minute_string(60.000)).to eq '01:00.000'
    end
  end

  describe '.seconds_to_hour_string' do
    it 'returns in seconds float' do
      expect(described_class.seconds_to_hour_string(3660.010)).to eq '01:01:00.010'
    end
  end
end
