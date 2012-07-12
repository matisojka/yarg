require 'spec_helper'

describe YARG::Name do

  before do
    YARG::DataStore.class_variable_set :@@stored_queries, nil
  end

  describe '#given' do

    it 'returns a random given name' do
      names = []
      100.times { names << YARG::Name.given }

      names.select { |name| !name.nil? || !name == '' }.size.should == 100

      names.uniq.size.should > 90
    end

  end

   describe '#given_name' do

     it 'is an alias of #given' do
       YARG::Name.method(:given_name).should == YARG::Name.method(:given)
     end

   end

   describe '#first' do

     it 'is an alias of #given' do
       YARG::Name.method(:first).should == YARG::Name.method(:given)
     end

   end

   describe '#given(:female)' do

     it 'returns female names' do
       names = []
       100.times { names << YARG::Name.given(:female) }

       names.select { |name| !name.nil? || !name == '' }.size.should == 100

       names.uniq.size.should > 90
     end

   end

   describe '#given(:male)' do
     it 'returns male names' do
       names = []
       100.times { names << YARG::Name.given(:male) }

       names.select { |name| !name.nil? || !name == '' }.size.should == 100

       names.uniq.size.should > 90
     end
   end

   describe '#surname' do
     it 'returns a random surname' do
       surnames = []
       100.times { surnames << YARG::Name.surname }

       surnames.select { |surname| !surname.nil? || !surname == '' }.size.should == 100

       surnames.uniq.size.should > 90
     end
   end

   describe '#given(:de)' do
     it 'returns random German given names' do
       names = []
       100.times { names << YARG::Name.given(:de) }

       names.select { |name| !name.nil? || !name == '' }.size.should == 100

       names.uniq.size.should > 90
     end
   end

end
