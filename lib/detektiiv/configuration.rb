# frozen_string_literal: true

module Detektiiv
  class Configuration
    attr_accessor :application_name, :logfile_path

    def initialize
      @application_name = ''
      @logfile_path     = '/tmp/detektiiv.log'
    end
  end
end
