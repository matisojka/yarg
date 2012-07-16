module YARG
  class Phone

    class << self

      def phone(country_code = nil)
        country_code = phones.keys.sample if country_code.nil?
        phone_class = phones[country_code]

        phone_class.phone
      end

      def random_digit(range)
        range.to_a.sample
      end

      private

      def phones
        {
          us: USPhoneNumber,
          de: GermanPhoneNumber
        }
      end

    end

    class USPhoneNumber < Phone

      class << self

        def phone
          "+#{international_phone_code} #{area_codes.sample} #{random_digit(2..9)}#{random_digit(0..9)}#{random_digit(0..9)} #{4.times.map { random_digit(0..9) }.join }"
        end

        def international_phone_code
          '1'
        end

        def area_codes
          DataStore.where(type: :phone_area_code, region: :us)
        end

      end

    end

    class GermanPhoneNumber < Phone

      class << self

        def phone
          area_code = area_codes.sample
          missing_numbers = 10 - area_code.length
          filling = missing_numbers.times.map { random_digit(0..9) }.join

          "+#{international_phone_code} #{area_code} #{filling}"
        end

        def international_phone_code
          '49'
        end

        def area_codes
          DataStore.where(type: :phone_area_code, region: :de)
        end

      end
    end

  end
end
