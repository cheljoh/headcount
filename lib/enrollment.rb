require_relative 'truncate'

class Enrollment

  attr_accessor :name, :kindergarten_participation, :high_school_graduation_rates

  def initialize(hash)
    @name = hash[:name]
    @kindergarten_participation = hash[:kindergarten_participation]
    @high_school_graduation_rates = hash[:high_school_graduation_rates]
  end

  def kindergarten_participation_by_year
    kindergarten_participation.map do |year, rate|
      [year, rate]
    end.to_h
  end

  def kindergarten_participation_in_year(year)
    if kindergarten_participation.keys.include?(year)
      value = kindergarten_participation[year]
    end
      value
  end

  def graduation_rate_by_year
    high_school_graduation_rates.map do |year, rate|
      [year, rate]
    end.to_h
  end

  def graduation_rate_in_year(year)
    if high_school_graduation_rates.keys.include?(year)
      value = high_school_graduation_rates[year]
    end
      value
  end

end
