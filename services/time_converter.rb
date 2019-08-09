require 'time'

class TimeConverter
  def self.minute_string_to_seconds(string)
    current_time_with_string_minutes = Time.strptime(string, '%M:%S.%L')
    current_time_without_minutes = Time.parse(Time.now.strftime('%Y-%m-%dT%H:00:00'))
    current_time_with_string_minutes - current_time_without_minutes
  end

  def self.hour_string_to_seconds(string)
    current_time_with_string_hour = Time.strptime(string, '%H:%M:%S.%L')
    current_time_without_hour = Time.parse(Time.now.strftime('%Y-%m-%dT%00:00:00'))
    current_time_with_string_hour - current_time_without_hour
  end

  def self.seconds_to_hour_string(seconds)
    Time.at(seconds).utc.strftime('%H:%M:%S')
  end
end
