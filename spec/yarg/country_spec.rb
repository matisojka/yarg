require 'spec_helper'

describe YARG::Country do

  describe '#name(:en)' do

    it 'returns a random English country name' do
      countries = []
      100.times { countries << YARG::Country.name(:en) }

      countries.select { |country| !country.nil? || !country == '' }.size.should == 100

      countries.uniq.size.should > 70
    end

    it 'return a random German country name' do
      countries = []
      100.times { countries << YARG::Country.name(:de) }

      countries.select { |country| !country.nil? || !country == '' }.size.should == 100

      countries.uniq.size.should > 70
    end

  end

end
