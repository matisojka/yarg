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
      alias given_name given

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
        DataStore.where(type: :given_name)
      end

      def male_given_names
        DataStore.where(type: :given_name, gender: :male)
      end

      def female_given_names
        DataStore.where(type: :given_name, gender: :female)
      end

      def surnames
        DataStore.where(type: :surname)
      end

    end

  end
end
