class Pilot
  attr_accessor :name, :code, :race, :laps

  def initialize(code, name, race)
    @name = name
    @code = code
    @race = race
    race.pilots << self
    @laps = []
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
    laps.map(&:average_speed).reduce(&:+) / laps.count
  end
end
