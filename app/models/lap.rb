# frozen_string_literal: true

class Lap
  extend BaseModel::AttributesType

  integer :number
  float :duration
  float :average_speed
  float :finish_time
  attribute :pilot, type: 'Pilot'
  attribute :race, type: 'Race'

  def initialize(number:, duration:, average_speed:, finish_time:, pilot:)
    self.number = number
    self.duration = duration
    self.average_speed = average_speed
    self.finish_time = finish_time
    self.pilot = pilot
    self.race = pilot.race
    pilot.add_to_laps self
  end

  def last?
    @number == @race.last_lap
  end
end
