require 'spec_helper'

describe YARG::Phone do

  describe '#phone' do

    it 'returns a random phone number' do
      phones = []
      100.times { phones << YARG::Phone.phone }

      phones.select { |phone| !phone.nil? || !phone == '' }.size.should == 100

      phones.uniq.size.should == 100
    end

    it 'returns a random US-American number' do
      phones = []
      100.times { phones << YARG::Phone.phone(:us) }

      phones.select { |phone| !phone.nil? || !phone == '' }.size.should == 100

      phones.uniq.size.should == 100
      phones.each { |phone| phone.length.should == 15 }
    end

    it 'returns a random German number' do
      phones = []
      100.times { phones << YARG::Phone.phone(:de) }

      phones.select { |phone| !phone.nil? || !phone == '' }.size.should == 100

      phones.uniq.size.should == 100
      phones.each { |phone| phone.length.should == 15 }
    end

    it 'throws an error if a non-supported country is requested' do
      expect { YARG::Phone.phone(:non_supported) }.to raise_error(YARG::NonSupportedCountryError)
    end

  end

end
