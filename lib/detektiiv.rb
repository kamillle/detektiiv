# frozen_string_literal: true

require "detektiiv/version"
require "detektiiv/configuration"

module Detektiiv
  class << self
    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Detektiiv::Configuration.new
    end

    def exec_patch!
      require "detektiiv/factory_runner_patch"

      ::FactoryBot::FactoryRunner.prepend Detektiiv::FactoryRunnerPatch
    end
  end
end

