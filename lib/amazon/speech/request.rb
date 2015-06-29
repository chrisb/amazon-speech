module Amazon
  module Speech
    class Request
      TYPES = [:launch, :intent, :session_ended]

      attr_reader :version, :session_id, :raw_request, :user, :type, :intent

      def intialize(request)
        @raw_request = request.is_a?(Hash) ? request : JSON.parse(request)
        @version     = @raw_request['version']
        @user        = @raw_request['session']['userId']
        @session_id  = @raw_request['session']['sessionId']
        @type        = @raw_request['request']['type'].gsub('Request', '').underscore.to_sym

        begin
          send "#{@type}_request"
        rescue NoMethodError
          raise UnknownSpeechRequest, @type
        end
      end

      def intent_request
        @intent = Amazon::Speech::Intent.parse @raw_request['intent']
      end

      def launch_request
        # nothing to see here
      end

      def session_ended_request
        # nothing to see here
      end

      def response
        case @type
        when :intent
          @intent.response
        end
      end

      def new_session?
        @raw_request['session']['new']
      end
    end
  end
end
