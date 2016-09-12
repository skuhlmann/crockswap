class ScheduleMaker
  attr_reader :start_date

  def initialize(date, defaults, num_of_weeks=1)
    @start_date = find_start_date(date)
    @swap_date = find_swap_date(defaults[:swap])
    @location = defaults[:location]
    @time = defaults[:time]
    @num_of_weeks = num_of_weeks
  end

  def create_weeks
    weeks = []
    @num_of_weeks.times do |i|
      new_week = {
        start_date: @start_date + (7 * i),
        swap_date: @swap_date + (7 * i),
        swap_location: @location,
        swap_time: @time
      }
      weeks << Week.new(new_week)
    end
    weeks
  end

  private

  def find_start_date(date)
    date.beginning_of_week
  end

  def find_swap_date(day_number)
    @start_date + (day_number - 1)
  end
end