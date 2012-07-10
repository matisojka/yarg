module YARG
  class Name

    class << self

      def given
        given_names.sample
      end
      alias first given

      private

      def given_names
        @given_names ||= male_given_names + female_given_names
      end

      def male_given_names
        return @male_given_names unless @male_given_names.nil?

        names = []
        File.open('data/name_given_male_usa.txt').each_line { |l| names.push l.chomp }

        @male_given_names = names
      end

      def female_given_names
        return @female_given_names unless @female_given_names.nil?

        names = []
        File.open('data/name_given_female_usa.txt').each_line { |l| names.push l.chomp }

        @female_given_names = names
      end

    end

  end
end
