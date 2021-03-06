require './lib/participation_analyst'
require './lib/district_repository'
require './lib/headcount_analyst'
require_relative 'test_helper'

class ParticipationAnalystTest < Minitest::Test

  def setup
    dr = DistrictRepository.new
    @headcount_analyst = HeadcountAnalyst.new(dr)
    @participation_analyst = ParticipationAnalyst.new(dr)
  end

  def test_graduation_rate_variation
    rate = @participation_analyst.graduation_rate_variation('ACADEMY 20', :against => 'COLORADO')
    assert_equal 1.194, rate
  end

  def test_compare_kindergarten_participation_rate_to_state_average
    rate = @participation_analyst.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'COLORADO')
    assert_equal 0.766, rate
  end

  def test_compare_kindergarten_participation_rate_to_another_district
    rate = @participation_analyst.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'YUMA SCHOOL DISTRICT 1')
    assert_equal 0.446, rate
  end

  def test_kindergarten_participation_rate_variation_trend
    trends = @participation_analyst.kindergarten_participation_rate_variation_trend('ACADEMY 20', :against => 'COLORADO')
    expected = ({2007=>0.737, 2006=>0.665, 2005=>0.503, 2004=>0.569, 2008=>0.724,
                2009=>0.735, 2010=>0.822, 2011=>0.922, 2012=>0.901, 2013=>0.918, 2014=>0.924})
    assert_equal expected, trends
  end

  def test_kindergarten_participation_against_high_school_graduation
    kindergarten_graduation_variance = @participation_analyst.kindergarten_participation_against_high_school_graduation("Academy 20")
    assert_equal 0.641, kindergarten_graduation_variance
  end

  def test_kindergarten_participation_correlates_with_high_school_graduation_district_true
    does_it_correlate = @participation_analyst.kindergarten_participation_correlates_with_high_school_graduation(for: 'ACADEMY 20')
    assert does_it_correlate
  end

  def test_kindergarten_participation_correlates_with_high_school_graduation_district_false
    does_it_correlate = @participation_analyst.kindergarten_participation_correlates_with_high_school_graduation(for: 'ADAMS COUNTY 14')
    refute does_it_correlate
  end

  def test_kindergarten_participation_correlates_with_high_school_graduation_statewide
    statewide_correlation = @participation_analyst.kindergarten_participation_correlates_with_high_school_graduation(:for => 'STATEWIDE')
    refute statewide_correlation
  end

  def test_kindergarten_participation_correlates_with_high_school_graduation_multiple_districts
    district_correlation = @participation_analyst.kindergarten_participation_correlates_with_high_school_graduation(:across => ["ACADEMY 20", 'PARK (ESTES PARK) R-3', 'YUMA SCHOOL DISTRICT 1'])
    assert district_correlation
  end

end
