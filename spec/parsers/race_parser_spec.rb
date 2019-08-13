# frozen_string_literal: true

RSpec.describe RaceParser do
  describe '.parse_from_log_file' do
    subject { described_class.parse_from_log_file(log_file) }
    context 'with a valid log file' do
      let(:log_file) { File.open(__dir__ + '/../support/fixture_files/valid.log') }

      it { is_expected.to be_a Race }
    end

    context 'with an invalid log file' do
      let(:log_file) { File.open(__dir__ + '/../support/fixture_files/invalid.log') }

      it 'raises an RaceParserError' do
        expect { subject }.to raise_error(RaceParserError)
          .with_message('Log file line 2 does not match Regex')
      end
    end
  end

  describe '.parse_result_to_stdout' do
    subject { described_class.parse_result_to_stdout(race) }

    let!(:race) { build(:race) }
    let!(:pilot) { build(:pilot, :with_laps_with_fixed_times, race: race, name: 'F.MASSA') }
    let(:expected_result) do
      "\"Melhor volta F.MASSA 01:00.000\"\n" \
        "\"Posição Código      Nome       Voltas  T. Prova   Melhor    V. Media   T. do 1º \"\n" \
        "\"   1º      1   F.MASSA           4    04:00.000 01:00.000     60.0    0.0       \"\n"
    end

    it 'prints the result to stdout' do
      expect { subject }.to output(expected_result).to_stdout
    end
  end
end
