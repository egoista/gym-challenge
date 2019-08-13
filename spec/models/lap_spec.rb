RSpec.describe Lap do
  describe '#initialize' do
    subject do
      described_class.new(
        number: number, duration: duration, average_speed: average_speed, finish_time: finish_time, pilot: pilot
      )
    end
    let(:number) { 1 }
    let(:duration) { 1.0 }
    let(:average_speed) { 1.0 }
    let(:finish_time) { 1.0 }
    let(:pilot) { build(:pilot) }

    context 'with valid params' do
      it { is_expected.to be_a Lap }

      it 'sets passed values' do
        expect(subject.number).to eq number
        expect(subject.duration).to eq duration
        expect(subject.average_speed).to eq average_speed
        expect(subject.finish_time).to eq finish_time
        expect(subject.pilot).to eq pilot
      end

      it 'sets race as pilot.race' do
        expect(subject.race).to eq pilot.race
      end

      it 'adds lap to pilot.laps' do
        subject
        expect(pilot.laps).to include(subject)
      end
    end
  end
  describe 'instance methods' do
    let(:lap) { build(:lap, number: number) }

    describe '#last?' do
      subject { lap.last? }

      context 'when the lap number is 4' do
        let(:number) { 4 }

        it { is_expected.to be_truthy }
      end

      context 'when the lap number is not 4' do
        let(:number) { 1 }

        it { is_expected.to be_falsey }
      end
    end
  end
end
