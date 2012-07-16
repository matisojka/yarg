module YARG
  class Country

    class << self

      def name(language)
        language = language.to_s.upcase.to_sym
        DataStore.where(type: :country, subtype: :name, language: language).sample
      end

    end

  end
end
