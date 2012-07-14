module YARG
  class Name

    class << self

      def given(criteria = [])
        DataStore.magic_query({ type: :given_name }, criteria).sample
      end
      alias first given
      alias given_name given

      def surname(criteria = [])
        DataStore.magic_query({ type: :surname }, criteria).sample
      end

      def full(criteria = [])
        "#{given(criteria)} #{surname(criteria)}"
      end
      alias full_name full

    end

  end

end

