module YARG
  class Phone

    class << self

      def phone(country_code = nil)
        country_code = phones.keys.sample if country_code.nil?
        phone_class = phones[country_code]

        raise NonSupportedCountryError if phone_class.nil?

        phone_class.phone
      end

      def random_digit(range)
        range.to_a.sample
      end

      private

      def phones
        {
          us: PhoneFormats::USPhoneNumber,
          de: PhoneFormats::GermanPhoneNumber
        }
      end

    end

  end

  class NonSupportedCountryError < StandardError; end

end
