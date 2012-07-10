module YARG
  class Name

    class Given < String

      def initialize(string, name_class)
        @name_class = name_class
        super string
      end

      def female
        @name_class.given_female
      end

      def male
        @name_class.given_male
      end

      def class
        String
      end

    end

    class << self

      def given
        Given.new(given_names.sample, self)
      end
      alias first given

      def given_female
        female_given_names.sample
      end

      def given_male
        male_given_names.sample
      end

      def surname
        surnames.sample
      end

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

      def surnames
        return @surnames unless @surnames.nil?

        surnames = []
        File.open('data/surnames_usa.txt').each_line { |l| surnames << l.chomp }

        @surnames = surnames
      end

    end

  end
end
