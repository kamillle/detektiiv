# frozen_string_literal: true

require "detektiiv/version"
require "detektiiv/configuration"

module Detektiiv
  class InitializationError < StandardError; end

  class << self
    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Detektiiv::Configuration.new
    end

    def exec_patch!
      raise InitializationError, 'exec_patch! must be called after load factory_bot gem' unless defined?(FactoryBot)

      require "detektiiv/factory_runner_patch"

      ::FactoryBot::FactoryRunner.prepend Detektiiv::FactoryRunnerPatch
    end
  end
end
