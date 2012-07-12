module YARG
  class DataStore

    class << self

      def where(criteria = {})
        files = get_files(criteria)

        files.map { |file| fetch_data(file) }.flatten
      end

      private

      # This method requires a criteria hash with a key-value relation.
      # It iterates over tagged_data_files and gets their value hashes,
      # which contain the matching tags. In the next step, it searches for
      # the next not matching key and as soon as it finds one, it abort the
      # bucle and set not_matching to the value of the first non matching tag
      def get_files(criteria)
        files = []

        tagged_data_files.each do |file_name, tags|
          not_matching = criteria.find do |key, value|
            tags[key] != value
          end

          files << file_name if not_matching.nil?
        end

        files
      end

      def fetch_data(file_name)
        [].tap do |data|
          File.open("data/#{file_name.to_s}.txt").each_line do |line|
            data << line.chomp
          end
        end
      end

      # This is a collection of data files which are used as data source
      # for some of the random methods.
      # A file needs to be stored under the /data directory in order to
      # be recognized by the data store.
      # The values are a hash of "tags" which define the data characteristics.
      def tagged_data_files
        {
          given_names_male_us: { type: :given_name, gender: :male, region: :us },
          given_names_female_us: { type: :given_name, gender: :female, region: :us },
          surnames_us: { type: :surname, region: :us },
          given_names_male_de: { type: :given_name, gender: :male, region: :de },
          given_names_female_de: { type: :given_name, gender: :female, region: :de }
        }
      end

    end

  end
end
