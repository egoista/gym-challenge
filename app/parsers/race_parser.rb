# frozen_string_literal: true

class RaceParserError < ArgumentError; end

class RaceParser
  class << self
    REGEX = /
      (?<finish_time>\d{2}:\d{2}:\d{2}.\d{3})\s{6}
      (?<code>\d{3})\s–\s
      (?<name>\w\.\w*)\s*
      (?<lap_number>\d*)\s*
      (?<duration>\d*:\d{2}\.\d{3})\s*
      (?<average_speed>[\d,]*)
    /x.freeze

    def parse_from_log_file(log_file)
      race = Race.new

      log_file.each_with_index do |line, index|
        next if index.zero?

        read_line(line, index, race)
      end

      race
    end

    def parse_result_to_stdout(race)
      print_best_lap(race)
      print_headers
      print_positions_summary(race)
    end

    private

    def read_line(line, index, race)
      raise RaceParserError, "Log file line #{index + 1} does not match Regex" unless line.match?(REGEX)

      line.match(REGEX) do |m|
        pilot = PilotBuilder.build_from_strings(m[:code], m[:name], race)
        LapBuilder.build_from_strings(
          m[:lap_number], m[:duration], m[:average_speed], m[:finish_time], pilot
        )
      end
    end

    def print_best_lap(race)
      best_lap = race.best_lap
      p "Melhor volta #{best_lap.pilot.name} #{TimeConverter.seconds_to_minute_string(best_lap.duration)}"
    end

    def print_headers
      p %W[
        #{fixed_size_string('Posição', 8, true)}
        #{fixed_size_string('Código', 7, true)}
        #{fixed_size_string('Nome', 15, true)}
        #{fixed_size_string('Voltas', 8, true)}
        #{fixed_size_string('T. Prova', 10, true)}
        #{fixed_size_string('Melhor', 10, true)}
        #{fixed_size_string('V. Media', 12, true)}
        #{fixed_size_string('T. do 1º', 10, true)}
      ].join
    end

    def print_positions_summary(race)
      race.positions
          .map { |position, pilot| [position, PilotFixedSizeDecorator.new(pilot)] }
          .each do |position, decorated_pilot|
            p pilot_summary(position, decorated_pilot, race)
          end
    end

    def pilot_summary(position, decorated_pilot, race)
      %W[
        #{fixed_size_string(position.to_s + 'º', 8, true)}
        #{decorated_pilot.formatted_code(7)}
        #{decorated_pilot.formatted_name(15)}
        #{decorated_pilot.formatted_laps(8)}
        #{decorated_pilot.formatted_total_time(10)}
        #{decorated_pilot.formatted_best_lap(10)}
        #{decorated_pilot.formatted_average_speed(12)}
        #{decorated_pilot.formatted_time_to_first_place(
          race.first_place.finish_time, 10
        )}
      ].join
    end

    def fixed_size_string(string, size, center = false)
      FixedSizeString.convert(string, size, center_allign: center)
    end
  end
end
