require 'spec_helper'

describe YARG::Name do

  describe '#given' do

    it 'returns a random given name' do
      names = []
      100.times { names << YARG::Name.given }

      names.select { |name| !name.nil? || !name == '' }.size.should == 100

      names.uniq.size.should > 90
    end

  end

  describe '#first' do

    it 'is an alias of #given' do
      YARG::Name.method(:first).should == YARG::Name.method(:given)
    end

  end

  describe '#given#female' do

    it 'returns female names only' do
      female_data = []
      File.open('data/name_given_female_usa.txt').each_line { |l| female_data  << l.chomp }

      names = []
      10.times { names << YARG::Name.given.female }

      names.each { |name| female_data.should include(name) }
    end

  end

  describe '#given#male' do
    it 'returns male names only' do
      male_data = []
      File.open('data/name_given_male_usa.txt').each_line { |l| male_data  << l.chomp }

      names = []
      10.times { names << YARG::Name.given.male }

      names.each { |name| male_data.should include(name) }
  describe '#surname' do
    it 'returns a random surname' do
      surname_data = []
      File.open('data/surnames_usa.txt').each_line { |l| surname_data  << l.chomp }

      surnames = []
      100.times { surnames << YARG::Name.surname }

      surnames.select { |surname| !surname.nil? || !surname == '' }.size.should == 100

      surnames.uniq.size.should > 90

      (surnames & surname_data).size.should == 100
    end
  end

end
