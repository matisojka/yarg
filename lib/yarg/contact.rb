module YARG
  class Contact

    class << self

      def country(language)
        language = language.to_s.upcase.to_sym
        DataStore.where(type: :country, subtype: :name, language: language).sample
      end

    end

  end
end
