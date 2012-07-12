require 'spec_helper'

describe YARG::DataStore do

  describe 'DataStore.where(type: :given_name)' do

    let :tagged_data_files do
      {
        given_names_male_us: { type: :given_name, gender: :male, region: :us },
        given_names_female_us: { type: :given_name, gender: :female, region: :us },
        surnames_us: { type: :surname, region: :us },
        given_names_male_de: { type: :given_name, gender: :male, region: :de },
        given_names_female_de: { type: :given_name, gender: :female, region: :de }
      }
    end

    subject(:data_store) { YARG::DataStore.new }

    before do
      data_store.stub(:tagged_data_files).and_return tagged_data_files
      data_store.stub(:fetch_data).and_return []
    end

    it 'returns an array of given names' do
      expected_names = [['Aaron', 'Mike'], ['Sarah']]
      data_store.stub(:fetch_data).and_return *expected_names

      names = data_store.where(type: :given_name)
      names.should == expected_names.flatten
    end

    it 'returns an array of female given names' do
      female_names = ['Adela', 'Nancey']
      male_names = ['Thomas', 'John']

      data_store.stub(:fetch_data).with(:given_names_male_us).and_return male_names
      data_store.stub(:fetch_data).with(:given_names_female_us).and_return female_names

      names = data_store.where(type: :given_name, gender: :female)
      names.should == female_names
    end

    it 'returns an array of surnames' do
      expected_surnames = ['Smith', 'Locke']
      data_store.stub(:fetch_data).and_return expected_surnames

      surnames = data_store.where(type: :surname)
      surnames.should == expected_surnames
    end

    it 'return an array of german given names' do
      expected_names = ['Hans', 'Sven']
      data_store.stub(:fetch_data).and_return expected_names

      names = data_store.where(type: :given_name, region: :de)
      names.should == expected_names
    end
  end
end
