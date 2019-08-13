RSpec.describe PilotBuilder do
  describe '.build_from_strings' do
    let(:race) { build(:race) }

    context 'when is a new pilot for the race' do
      it 'build and returns a valid Pilot' do
        expect(Pilot).to receive(:new).and_call_original

        pilot = described_class.build_from_strings(
          '038', 'F.MASSA', race
        )

        expect(pilot).to be_a Pilot
        expect(pilot.code).to eq '038'
        expect(pilot.name).to eq 'F.MASSA'
      end
    end

    context 'when is not a new pilot for the race' do
      let!(:previous_pilot) { build(:pilot, code: '038', name: 'F.MASSA', race: race) }

      it 'returns the Pilot' do
        expect(Pilot).to_not receive(:new)

        pilot = described_class.build_from_strings(
          '038', 'F.MASSA', race
        )

        expect(pilot).to be_a Pilot
        expect(pilot.code).to eq '038'
        expect(pilot.name).to eq 'F.MASSA'
      end
    end
  end
end
