require 'csv'
require_relative 'enrollment_repository'
require_relative 'enrollment'
require_relative 'district'

class DistrictRepository

  attr_accessor :districts

  def initialize
    @districts = {}
  end

  def load_data(hash) #search through enrollment hash, create a new district instance for each one
    enrollment_repo = EnrollmentRepository.new
    enrollment_repo.load_data(hash)
    enrollment_repo.enrollment_objects.each do |district_name, enrollment_object|
      d = District.new({:name => district_name, :enrollment => enrollment_object}) #need to set enrollment to something
      districts[district_name] = d
    end
  end

  def find_by_name(district_name) #returns nil or instance of District
    districts[district_name.upcase]
  end

  def find_all_matching(name_fragment)
    matching_districts = districts.select do |district_name|
      district_name.include?(name_fragment.upcase)
    end
    matching_districts.values
  end

end

# dr = DistrictRepository.new
# dr.load_data({
#   :enrollment => {
#     :kindergarten => "../data/Kindergartners in full-day program.csv"
#   }
# })
#
# district = dr.find_by_name("ACADEMY 20")
# puts district.enrollment.kindergarten_participation_in_year(2010)




# def load_data(hash) #loads the file you want it to load
#   data_path = hash[:enrollment][:kindergarten]
#   contents = CSV.open data_path, headers: true, header_converters: :symbol
#
#   hashes = {}
#
#   contents.each do |row|
#     district = row[:location].upcase
#
#     if !hashes.has_key?(district)
#       hashes[district] = row
#     end
#
#     hashes.each do |key, value|
#       districts = District.new(:name => key, :value => value)
#       puts districts
#
#
#
#     end
#
#     #hashes.fetch(district)
#   end
#   # district objects
# end

# Dir.foreach('../data') do |item| #prints out name of each district
#   next if File.directory? item
#   contents = CSV.open "../data/#{item}", headers: true, header_converters: :symbol
#   contents.each do |row|
#   district = row[:location]
#   puts district
#   end
# end