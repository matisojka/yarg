module YARG
  class DataStore

    class << self

      def where(criteria = {})
        type = criteria[:type]

        @files = []
        get_files_for_key(type, mapping)
        bb = @files.map { |file| fetch_data(file) }.flatten
      end

      private

      def files
        @files ||= []
      end

      def get_files_for_key(key, hash)
        hash[key] && hash[key].each do |key, value|
          if value.is_a?(Hash)
            get_files_for_key(key, { key => value })
          elsif value.is_a?(Symbol)
            files << value
          end
        end
      end

      def fetch_data(file_name)
        data = []
        File.open("data/#{file_name.to_s}.txt").each_line { |l| data << l.chomp }

        data
      end

      def mapping
        {
          given_name: {
            region: {
              us: {
                gender: {
                  male: :given_names_male_us,
                  female: :given_names_female_us
                },
              },
            },
          },
          surname: {
            region: {
              us: :surnames_us
            }
          }
        }
      end

    end

  end
end
