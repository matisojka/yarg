module YARG
  class Country

    class << self

      def name(language)
        DataStore.where(type: :country, subtype: :name, language: language).sample
      end

    end

  end
end
