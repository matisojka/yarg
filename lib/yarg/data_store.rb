module YARG
  class DataStore

    def self.where(criteria = {})
      (@data_store ||= new).where(criteria)
    end

    def self.magic_query(criteria, tags)
      (@data_store ||= new).magic_query(criteria, tags)
    end

    def where(criteria = {})
      stored_query = find_stored_query(criteria)

      if stored_query.nil?
        files = get_files(criteria)
        query_result = files.map { |file| fetch_data(file) }.flatten.uniq
        stored_queries[criteria.sort] = query_result
      else
        stored_query
      end
    end

    def magic_query(criteria, tags)
      criteria = criteria.dup

      Array(tags).each do |criterion|
        criteria[tags_with_type[criterion]] = criterion
      end

      where(criteria)
    end

    private

    def find_stored_query(criteria)
      stored_queries.each do |query, result|
        return result if query == criteria.sort
      end

      nil
    end

    def stored_queries
      @stored_queries ||= {}
    end

    # This method requires a criteria hash with a key-value relation.
    # It iterates over tagged_data_files and gets their value hashes,
    # which contain the matching tags. In the next step, it searches for
    # the next not matching key and as soon as it finds one, it aborts the
    # bucle and set not_matching to the value of the first non matching tag
    #
    # Example of criteria:
    # {
    #   type: :given_name,
    #   gender: :female
    # }
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
    # for some of the random generation methods.
    # A file needs to be stored under the /data directory with .txt extension
    # in order to be recognized by the data store.
    # The values are in form of a hash of "tags" which defines
    # the data characteristics.
    def tagged_data_files
      {
        given_names_male_us: { type: :given_name, gender: :male, region: :us },
        given_names_female_us: { type: :given_name, gender: :female, region: :us },
        surnames_us: { type: :surname, region: :us },
        surnames_de: { type: :surname, region: :de },
        given_names_male_de: { type: :given_name, gender: :male, region: :de },
        given_names_female_de: { type: :given_name, gender: :female, region: :de },
        phone_area_codes_us: { type: :phone_area_code, region: :us },
        country_names_en: { type: :country, subtype: :name, language: :en }
      }
    end

    def tags_with_type
      @tags ||= {}.tap do |tag_hash|
        tagged_data_files.each do |_, tags|
          tags.invert.each { |key, value| tag_hash[key] = value }
        end
      end
    end

  end
end
