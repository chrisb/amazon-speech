module Amazon
  module Speech
    class Session
      def initialize
        @requests = []
      end

      def new?
        true if @requests.empty? || @requests.last.new_session?
      end
    end
  end
end
