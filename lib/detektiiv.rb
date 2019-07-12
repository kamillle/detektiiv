require "detektiiv/version"
require "detektiiv/configuration"
require "active_support/lazy_load_hooks"

module Detektiiv
  class << self
    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Detektiiv::Configuration.new
    end

    def exec_patch!
      ActiveSupport.on_load :factory_bot do
        require "detektiiv/factory_runner_patch"
      end
    end
  end
end

