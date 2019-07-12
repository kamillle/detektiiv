module Detektiiv
  class Configuration
    attr_accessor :application_name, :logfile_path

    def initializer
      @application_name = ::Rails.application.class.name.split('::').first.underscore
      @logfile_path     = '/tmp/detektiiv.log'
    end
  end
end
