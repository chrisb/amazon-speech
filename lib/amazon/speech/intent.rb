module Amazon
  module Speech
    class Intent
      @@intents = {}

      attr_reader :name, :slots

      def initialize(name, slots = {})
        @name  = name
        @slots = slots
      end

      def response
        "I understood your request for #{name} but I'm not quite sure how to respond to it."
      end

      def self.parse(intent)
        name  = intent['name']
        klass = @@intents[name]
        fail "uknown intent: #{name}" unless klass
        klass.new name, intent['slots']
      end

      def self.register(name, klass = self)
        @@intents[name.to_sym] = klass
      end
    end
  end
end
