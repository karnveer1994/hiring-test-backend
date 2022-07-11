require_relative 'parse_info'
require_relative 'entries'

class PeopleController
  include ParseInfo
  include Entries

  def initialize(params)
    @params = params
  end

  def normalize
    csv_parsed_info = parse(params)

    sorted_hash_array = merge_and_sort(csv_parsed_info, params[:order])

    formatted_csv(sorted_hash_array).split("\n")
  end

  private

  attr_reader :params
end
