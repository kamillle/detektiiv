require "detektiiv/version"
require "detektiiv/configuration"

module Detektiiv
  class << self
    def configure
      yield(configuration)
    end

    private

    def configuration
      @configuration ||= Detektiiv::Configuration.new
    end
  end
end
