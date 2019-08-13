RSpec.describe PilotFixedSizeDecorator do
  describe 'instance methods' do
    let(:pilot) { pilot = build(:pilot, :with_laps_with_fixed_times, name: 'name') }

    describe '#formatted_code' do
      subject { described_class.new(pilot).formatted_code(10) }

      it { is_expected.to eq '    1     ' }
    end

    describe '#formatted_name' do
      subject { described_class.new(pilot).formatted_name(10) }

      it { is_expected.to eq 'name      ' }
    end

    describe '#formatted_laps' do
      subject { described_class.new(pilot).formatted_laps(10) }

      it { is_expected.to eq '    4     ' }
    end

    describe '#formatted_total_time' do
      subject { described_class.new(pilot).formatted_total_time(10) }

      it { is_expected.to eq '04:00.000 ' }
    end

    describe '#formatted_best_lap' do
      subject { described_class.new(pilot).formatted_best_lap(10) }

      it { is_expected.to eq '01:00.000 ' }
    end

    describe '#formatted_average_speed' do
      subject { described_class.new(pilot).formatted_average_speed(10) }

      it { is_expected.to eq '   60.0   ' }
    end

    describe '#formatted_time_to_first_place' do
      subject { described_class.new(pilot).formatted_time_to_first_place(1_000_000, 10) }

      context 'when the pilot finished the race' do
        it { is_expected.to eq '996400.0  ' }
      end

      context 'when the pilot did not finished the race' do

        it 'returns dashes' do
          expect(pilot).to receive(:finish_time).and_return(Float::INFINITY)

          expect(subject).to eq '--------  '
        end
      end
    end
  end
end