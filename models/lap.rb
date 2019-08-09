class Lap
  attr_accessor :number, :duration, :average_speed, :finish_time, :pilot, :race

  def initialize(number:, duration:, average_speed:, finish_time:, pilot:)
    @number = number
    @duration = duration
    @average_speed = average_speed
    @finish_time = finish_time
    @pilot = pilot
    @race = pilot.race
    pilot.laps << self
  end

  def last?
    @number == @race.last_lap
  end
end
