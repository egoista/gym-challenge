# frozen_string_literal: true

RSpec.describe Pilot do
  describe '.initialize' do
    subject { described_class.new(code: code, name: name, race: race) }
    let(:code) { 'code' }
    let(:name) { 'name' }
    let(:race) { Race.new }

    context 'with valid params' do
      it { is_expected.to be_a Pilot }

      it 'sets passed values' do
        expect(subject.code).to eq code
        expect(subject.name).to eq name
      end
      it 'adds pilot to race.pilots' do
        subject
        expect(race.pilots).to include(subject)
      end
    end

    context 'with invalid code' do
      let(:code) { 1 }

      it 'raises an argument erorr' do
        expect { subject }.to raise_error(ArgumentError)
          .with_message('Expected a String value for Pilot#code, but got a Integer')
      end
    end

    context 'with invalid name' do
      let(:name) { 1 }

      it 'raises an argument erorr' do
        expect { subject }.to raise_error(ArgumentError)
          .with_message('Expected a String value for Pilot#name, but got a Integer')
      end
    end

    context 'with invalid race' do
      let(:race) { 1 }

      it 'raises an argument erorr' do
        expect { subject }.to raise_error(ArgumentError)
          .with_message('Expected a Race value for Pilot#race, but got a Integer')
      end
    end
  end

  describe 'instance methods' do
    let(:pilot) { build(:pilot) }

    describe '#finish_time' do
      subject { pilot.finish_time }

      context 'when pilot does not have laps' do
        it { is_expected.to eq Float::INFINITY }
      end

      context 'when pilot finished the race' do
        let(:laps) { build_list(:lap, 4, pilot: pilot) }

        it 'returns last lap finish_time' do
          last_lap = laps.find(&:last?)

          expect(subject).to eq last_lap.finish_time
        end
      end

      context 'when pilot did not finished the race' do
        let(:laps) { build_list(:lap, 3, pilot: pilot) }

        it { is_expected.to eq Float::INFINITY }
      end
    end

    describe '#total_time' do
      subject { pilot.total_time }

      context 'when pilot does not have laps' do
        it { is_expected.to eq 0 }
      end

      context 'when pilot have laps' do
        let!(:laps) { build_list(:lap, 2, pilot: pilot) }

        it { is_expected.to eq laps.sum(&:duration) }
      end
    end

    describe '#best_lap' do
      subject { pilot.best_lap }

      context 'when pilot does not have laps' do
        it { is_expected.to be_nil }
      end

      context 'when pilot have laps' do
        let!(:lap1) { build(:lap, pilot: pilot, duration: 10.0) }
        let!(:lap2) { build(:lap, pilot: pilot, duration: 20.0) }

        it { is_expected.to be lap1 }
      end
    end

    describe '#average_speed' do
      subject { pilot.average_speed }

      context 'when pilot does not have laps' do
        it { is_expected.to be_nil }
      end

      context 'when pilot have laps' do
        let!(:lap1) { build(:lap, pilot: pilot, average_speed: 10.0) }
        let!(:lap2) { build(:lap, pilot: pilot, average_speed: 20.0) }

        it { is_expected.to be 15.0 }
      end
    end
  end
end
