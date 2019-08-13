# frozen_string_literal: true

class AnalyzeRaceLogCommand
  class << self
    def run(args)
      file_path = args[0]
      unless file_path
        p 'Por favor informe o caminho para arquivo de log.'
        return
      end

      file = open_file(file_path)

      run_parser(file) if file
    end

    private

    def open_file(file_path)
      File.open(File.join(__dir__, '../../', file_path))
    rescue Errno::ENOENT
      p 'Caminho do log informado não é valido. O caminho deve ser relativo a raiz da aplicação'

      nil
    end

    def run_parser(file)
      race = RaceParser.parse_from_log_file(file)

      RaceParser.parse_result_to_stdout(race)
    rescue RaceParserError => e
      p "Não foi possivel ler o arquivo, message de erro: '#{e.message}.'"
    end
  end
end
