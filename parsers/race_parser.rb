require 'pry'
require_relative '../models/pilot'
require_relative '../models/race'
require_relative '../models/lap'
require_relative '../builders/lap_builder'
require_relative '../services/time_converter.rb'

class RaceParser
  REGEX = %r{
    (?<finish_time>[\d:\.]*)\s*
    (?<code>\d{3})\s–\s
    (?<name>\w\.\w*)\s*
    (?<lap_number>\d*)\s*
    (?<duration>[\d:\.]*)\s*
    (?<average_speed>[\d,]*)
  }x
  
  def self.parse_from_log_file(log_file)
    race = Race.new
    # binding.pry
    log_file.each_with_index do |line, index|
      next if index == 0

      line.match(REGEX) do |m|
        pilot = race.pilots.find { |pilot| pilot.code == m[:code]}
        pilot = Pilot.new(m[:code], m[:name], race) unless pilot
        LapBuilder.build_from_strings(m[:lap_number], m[:duration], m[:average_speed], m[:finish_time], pilot)
      end
    end

    race
  end

  def self.parse_result_to_string(race)
    best_lap = race.best_lap
    p "Best lap #{best_lap.pilot.name} #{best_lap.duration}"
    first_place = race.positions.values.first
    race.positions.map do |position, pilot|
      p "#{position} #{pilot.code} #{pilot.name} #{pilot.laps.count} #{TimeConverter.seconds_to_hour_string(pilot.total_time)} #{pilot.best_lap.duration} #{pilot.average_speed} #{first_place.finish_time - pilot.finish_time}"
    end
  end
end
