class PilotFixedSizeDecorator < SimpleDelegator
  def formatted_code(size)
    FixedSizeString.convert(code, size, center_allign: true)
  end

  def formatted_name(size)
    FixedSizeString.convert(name, size)
  end

  def formatted_laps(size)
    FixedSizeString.convert(laps.count, size, center_allign: true)
  end

  def formatted_total_time(size)
    FixedSizeString.convert(
      TimeConverter.seconds_to_minute_string(total_time),
      size,
      center_allign: true
    )
  end

  def formatted_best_lap(size)
    FixedSizeString.convert(
      TimeConverter.seconds_to_minute_string(best_lap.duration),
      size,
      center_allign: true
    )
  end

  def formatted_average_speed(size)
    FixedSizeString.convert(average_speed.round(3), size, center_allign: true)
  end

  def formatted_time_to_first_place(first_place_time, size)
    time = first_place_time - finish_time
    if time.abs == Float::INFINITY
      FixedSizeString.convert('--------', size)
    else
      FixedSizeString.convert(time.round(3), size)
    end
  end
end
