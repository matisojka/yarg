module YARG
  module PhoneFormats

    class USPhoneNumber
      extend PhoneFormatsHelper

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

  end
end

