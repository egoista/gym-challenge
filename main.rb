require_relative 'parsers/race_parser'

class Main
  race = RaceParser.parse_from_log_file(File.open('race.log'))
  RaceParser.parse_result_to_string(race)
end
