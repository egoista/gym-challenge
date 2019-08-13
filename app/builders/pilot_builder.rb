class PilotBuilder
  def self.build_from_strings(code_string, name_string, race)
    pilot = race.pilots.find { |p| p.code == code_string }
    pilot ||= Pilot.new(code: code_string, name: name_string, race: race)

    pilot
  end
end
