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
    let!(:pilot) { build(:pilot, race: race, name: 'F.MASSA') }
    let!(:laps) do
      (1..4).each do |n|
        build(:lap, number: n, pilot: pilot, duration: 60.0, average_speed: 60.111)
      end
    end
    let(:expected_result) do
      "\"Melhor volta #{pilot.name} 01:00.000\"\n"+
        "\"Posição Código      Nome       Voltas  T. Prova   Melhor    V. Media   T. do 1º \"\n"+
        "\"   1º      1   #{pilot.name}           4    04:00.000 01:00.000    #{pilot.average_speed.round(3)}   0.0       \"\n"
    end

    it 'prints the result to stdout' do
      expect { subject }.to output(expected_result).to_stdout
    end
  end
end
