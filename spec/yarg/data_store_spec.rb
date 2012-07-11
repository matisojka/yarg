require 'spec_helper'

describe YARG::DataStore do

  describe 'DataStore.where(type: :given_name)' do

    let :mapping do
      {
        given_name: {
          region: {
            us: {
              gender: {
                male: :given_names_male_us,
                female: :given_names_female_us
              },
            },
          },
        },
        surname: {
          region: {
            us: :surnames_us
          }
        }
      }
    end

    it 'returns an array of given names' do
      expected_names = [['Aaron', 'Mike'], ['Sarah']]
      YARG::DataStore.stub(:mapping).and_return mapping
      YARG::DataStore.stub(:fetch_data).and_return *expected_names

      names = YARG::DataStore.where(type: :given_name)
      names.should == expected_names.flatten
    end

    it 'returns an array of surnames' do
      expected_surnames = ['Smith', 'Locke']
      YARG::DataStore.stub(:mapping).and_return mapping
      YARG::DataStore.stub(:fetch_data).and_return expected_surnames

      surnames = YARG::DataStore.where(type: :surname)
      surnames.should == expected_surnames
    end
  end
end
