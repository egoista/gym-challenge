# frozen_string_literal: true

class Pilot
  extend BaseModel::AttributesType

  string :name
  string :code
  attribute :race, type: 'Race'
  array :laps, type: 'Lap'

  def initialize(code:, name:, race:)
    self.name = name
    self.code = code
    self.race = race
    race.add_to_pilots self
  end

  def finish_time
    last_lap = laps.find(&:last?)
    last_lap ? last_lap.finish_time : Float::INFINITY
  end

  def total_time
    laps.sum(&:duration)
  end

  def best_lap
    laps.min_by(&:duration)
  end

  def average_speed
    average_speed_sum = laps.map(&:average_speed).reduce(&:+)

    average_speed_sum / laps.count if average_speed_sum
  end
end
