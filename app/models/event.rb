class Event < ApplicationRecord
  has_many :conditions
  has_many :movements

  def sleep_score
    score = 10
    distance = 0

    conditions = {
      time: {
        optimal: (7..9).to_a,
        average: total_time_asleep,
        normalizer: 1
      },
      light: {
        optimal: (0..10).to_a,
        average: average_of(:light),
        normalizer: 0.03
      },
      noise: {
        optimal: (0..40).to_a,
        average: average_of(:noise),
        normalizer: 0.03
      },
      temperature: {
        optimal: (65..75).to_a,
        average: average_of(:temperature),
        normalizer: 0.03
      }
    }

    conditions.each do |condition, values|
      optimal = values[:optimal]
      average = values[:average]
      normalizer = values[:normalizer]

      unless optimal.include? average
        if average < optimal.first
          distance = (average - optimal.first).abs
        else
          distance = (average - optimal.last).abs
        end
      end

      score -= (distance * normalizer)
    end

    score.round
  end

  def average_of(condition)
    self.conditions.map(&condition).inject{|sum, el| sum + el}.to_f / self.conditions.size
  end

  def total_time_asleep
    ((self.stopped_at.to_time - self.created_at.to_time) / 60.0 / 60.0).round(1)
  end

  def total_time_asleep_formatted
    time_asleep = total_time_asleep
    hours = time_asleep.floor
    minutes = ((time_asleep % hours) * 60).round

    "#{hours}h #{minutes}m"
  end
end
