require 'spec_helper'

#######################################################
# DO NOT CHANGE THIS FILE - WRITE YOUR OWN SPEC FILES #
#######################################################
RSpec.describe 'App Functional Test' do
  describe 'dollar and percent formats sorted by first_name' do
    let(:params) do
      {
        dollar_format: File.read('spec/fixtures/people_by_dollar.txt'),
        percent_format: File.read('spec/fixtures/people_by_percent.txt'),
        order: :first_name,
      }
    end
    let(:people_controller) { PeopleController.new(params) }

    it 'parses input files and outputs normalized data' do
      normalized_people = people_controller.normalize

      # Expected format of each entry: `<first_name>, <city>, <birthdate M/D/YYYY>`
      expect(normalized_people).to eq [
        'Elliot, New York City, 5/4/1947',
        'Mckayla, Atlanta, 5/29/1986',
        'Rhiannon, Los Angeles, 4/30/1974',
        'Rigoberto, New York City, 1/5/1962',
      ]
    end
  end

  describe 'Parse people information in csv' do
    let(:params) do
      {
        dollar_format: File.read('spec/fixtures/people_by_dollar.txt'),
        percent_format: File.read('spec/fixtures/people_by_percent.txt'),
        order: :first_name,
      }
    end
    let(:people_controller) { PeopleController.new(params) }

    it 'Should parsed people information to csv' do
      parsed_csv = people_controller.parse(params)

      expect(parsed_csv.first.class).to eq CSV::Table
    end

  end

  describe 'csv formatted people information' do
    let(:params) do
      {
        order: :first_name,
      }
    end

    let(:people_controller) { PeopleController.new(params) }

    it 'formatted data' do
      sorted_hash_array = [{"first_name"=>"Elliot", "city"=>"New York City", "birthdate"=>"5/4/1947"}, {"first_name"=>"Mckayla", "city"=>"Atlanta", "birthdate"=>"5/29/1986"}, {"city"=>"Los Angeles", "birthdate"=>"4/30/1974", "last_name"=>"Nolan", "first_name"=>"Rhiannon"}, {"city"=>"New York City", "birthdate"=>"1/5/1962", "last_name"=>"Bruen", "first_name"=>"Rigoberto"}]

      formatted_csv = people_controller.formatted_csv(sorted_hash_array)

      expect(formatted_csv).to eq "Elliot, New York City, 5/4/1947\nMckayla, Atlanta, 5/29/1986\nRhiannon, Los Angeles, 4/30/1974\nRigoberto, New York City, 1/5/1962\n"
    end
  end
end
