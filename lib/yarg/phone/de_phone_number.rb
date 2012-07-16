module YARG
  module PhoneFormats

    class GermanPhoneNumber
      extend PhoneFormatsHelper

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

