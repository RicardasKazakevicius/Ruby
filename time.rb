require 'time'
# This class describes rent start and end times
class Time
  attr_reader :start_at, :end_at

  def start_at=(start_at)
    start_at = Time.parse(start_at.to_s)
    @start_at = start_at
  end

  def end_at=(end_at)
    end_at = Time.parse(end_at.to_s)
    @end_at = end_at
  end

  def duration
    # Time in hours
    (end_at - start_at) / 3600
  end
end
