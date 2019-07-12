require "detektiiv/version"
require "detektiiv/configuration"
require "active_support/lazy_load_hooks"

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

ActiveSupport.on_load :factory_bot do
  # TODO: このblock内でfactory_botにパッチを当てる
  #       パッチ自体は別のクラスに隠蔽する
end
