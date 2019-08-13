# frozen_string_literal: true

RSpec.describe AnalyzeRaceLogCommand do
  describe '.run' do
    subject { described_class.run(args) }

    context 'when does not pass args 0' do
      let(:args) { [] }
      let(:message) { "\"Por favor informe o caminho para arquivo de log.\"\n" }

      it 'asks for a log file in the stdout' do
        expect { subject }.to output(message).to_stdout
      end
    end

    context 'when pass invalid path' do
      let(:args) { ['no_file.log'] }
      let(:message) { "\"Caminho do log informado não é valido. O caminho deve ser relativo a raiz da aplicação\"\n" }

      it 'asks for a log file in the stdout' do
        expect { subject }.to output(message).to_stdout
      end
    end

    context 'when pass valid path' do
      let(:args) { ['spec/support/fixture_files/valid.log'] }

      context 'when race parser does not raises an error' do
        it 'calls parser parse_result_to_stdout' do
          expect(RaceParser).to receive(:parse_from_log_file)
          expect(RaceParser).to receive(:parse_result_to_stdout)

          subject
        end
      end

      context 'when race parser raises an RaceParserError' do
        let(:message) { "\"Não foi possivel ler o arquivo, message de erro: 'RaceParserError.'\"\n" }
        it 'calls parser parse_result_to_stdout' do
          expect(RaceParser).to receive(:parse_from_log_file).and_raise(RaceParserError)

          expect { subject }.to output(message).to_stdout
        end
      end
    end
  end
end
