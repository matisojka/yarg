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

end
