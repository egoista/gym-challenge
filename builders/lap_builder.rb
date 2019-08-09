require_relative '../models/lap'
require_relative '../services/time_converter'

class LapBuilder
  def self.build_from_strings(lap_number_string, duration_string, average_speed_string, finish_time_string, pilot)
    params = {
      number: lap_number_string.to_i,
      duration: TimeConverter.minute_string_to_seconds(duration_string),
      average_speed: average_speed_string.sub(',', '.').to_f,
      finish_time: TimeConverter.hour_string_to_seconds(finish_time_string),
      pilot: pilot
    }

    Lap.new(params)
  end
end
