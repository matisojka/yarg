module YARG
  module PhoneFormats
    module PhoneFormatsHelper

      def extended(base)
        base.extend self
      end

      def random_digit(range)
        range.to_a.sample
      end

    end
  end
end
