class Race
  attr_accessor :pilots

  LAST_LAP = 4

  def initialize
    @pilots = []
  end

  def laps
    @pilots.map(&:laps).flatten
  end

  def last_lap
    LAST_LAP
  end

  def best_lap
    laps.min_by(&:duration)
  end

  def positions
    position = 1
    pilots.sort_by(&:finish_time).each_with_object({}) do |pilot, hash|
      hash[position] = pilot
      position += 1
    end
  end
end
