# frozen_string_literal: true

RSpec.describe Race do
  describe 'instance methods' do
    let(:race) { build(:race) }

    describe '#add_to_pilots' do
      subject { race.add_to_pilots(pilot) }

      context 'when pass a Pilot' do
        let(:pilot) { build(:pilot) }

        it { is_expected.to be_truthy }
      end

      context 'when does not pass a Pilot' do
        let(:pilot) { 'anything' }

        it 'raises a arbument error' do
          expect { subject }.to raise_error(ArgumentError)
            .with_message('Expected a Pilot value for Race#pilots, but got a String')
        end
      end
    end

    describe '#laps' do
      subject { race.laps }

      context 'when does not have pilots' do
        it { is_expected.to eq [] }
      end

      context 'when have a pilot' do
        let(:pilot) { build(:pilot, race: race) }
        let!(:laps) { build_list(:lap, 2, pilot: pilot) }
        it { is_expected.to eq laps }
      end

      context 'when have many pilots' do
        let(:pilot1) { build(:pilot, race: race) }
        let(:pilot2) { build(:pilot, race: race) }
        let!(:laps1) { build_list(:lap, 2, pilot: pilot1) }
        let!(:laps2) { build_list(:lap, 2, pilot: pilot2) }

        it { is_expected.to eq laps1 + laps2 }
      end
    end

    describe '#last_lap' do
      subject { race.last_lap }

      it { is_expected.to eq Race::LAST_LAP }
    end

    describe '#best_lap' do
      subject { race.best_lap }

      context 'when does not have pilots' do
        it { is_expected.to be_nil }
      end

      context 'when have a pilot' do
        let(:pilot) { build(:pilot, race: race) }
        let!(:lap1) { build(:lap, pilot: pilot, duration: 10.0) }
        let!(:lap2) { build(:lap, pilot: pilot, duration: 20.0) }

        it { is_expected.to eq lap1 }
      end

      context 'when have many pilots' do
        let(:pilot1) { build(:pilot, race: race) }
        let(:pilot2) { build(:pilot, race: race) }
        let!(:lap1) { build(:lap, pilot: pilot1, duration: 10.0) }
        let!(:lap2) { build(:lap, pilot: pilot2, duration: 20.0) }

        it { is_expected.to eq lap1 }
      end
    end

    describe '#positions' do
      subject { race.positions }

      context 'when does not have pilots' do
        it { is_expected.to eq({}) }
      end

      context 'when have a pilot' do
        let(:pilot) { build(:pilot, race: race) }

        context 'when pilot does not have laps' do
          it { is_expected.to eq({}) }
        end

        context 'when pilot have laps' do
          let!(:lap) { build(:lap, pilot: pilot) }

          it { is_expected.to eq(1 => pilot) }
        end
      end

      context 'when have many pilots' do
        let(:pilot1) { build(:pilot, race: race) }
        let(:pilot2) { build(:pilot, race: race) }

        context 'when pilots does not have laps' do
          it { is_expected.to eq({}) }
        end

        context 'when pilots have laps' do
          let!(:laps1) { build_list(:lap, 4, pilot: pilot1, finish_time: 1000.0) }
          let!(:laps2) { build_list(:lap, 4, pilot: pilot2, finish_time: 2000.0) }

          it { is_expected.to eq(1 => pilot1, 2 => pilot2) }
        end
      end
    end

    describe '#first_place' do
      subject { race.first_place }

      context 'when does not have pilots' do
        it { is_expected.to be_nil }
      end

      context 'when have a pilot' do
        let(:pilot) { build(:pilot, race: race) }

        context 'when pilot does not have laps' do
          it { is_expected.to be_nil }
        end

        context 'when pilot have laps' do
          let!(:lap) { build(:lap, pilot: pilot) }

          it { is_expected.to eq pilot }
        end
      end

      context 'when have many pilots' do
        let(:pilot1) { build(:pilot, race: race) }
        let(:pilot2) { build(:pilot, race: race) }

        context 'when pilots does not have laps' do
          it { is_expected.to be_nil }
        end

        context 'when pilots have laps' do
          let!(:laps1) { build_list(:lap, 4, pilot: pilot1, finish_time: 1000.0) }
          let!(:laps2) { build_list(:lap, 4, pilot: pilot2, finish_time: 2000.0) }

          it { is_expected.to eq pilot1 }
        end
      end
    end
  end
end
