require "amazon/speech/version"

module Amazon
  module Speech

    module_function

    def respond_to(params = {})
      Amazon::Speech::Request.new(params).response
    end
  end
end
