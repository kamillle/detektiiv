# frozen_string_literal: true

module Detektiiv
  module FactoryRunnerPatch
    def run
      logging_bad_factory_call

      super
    end

    private

    def logging_bad_factory_call
      factory_defined_filename = FactoryBot
                                  .factory_by_name(@name)
                                  .instance_variable_get(:@definition)
                                  .instance_variable_get(:@declarations)
                                  .instance_variable_get(:@declarations)[0]
                                  .instance_variable_get(:@block)


      if factory_defined_filename&.to_s&.include?("#{Detektiiv.configuration.application_name}/spec/factories") || factory_defined_filename&.to_s&.include?('factory_bot') || factory_defined_filename.nil?
        return
      else
        logger.debug(filepath: factory_defined_filename)
        logger.debug(caller: caller.select {|i| i.include?("#{Detektiiv.configuration.application_name}/spec") }.to_s)
      end
    end

    def logger
      @logger ||= Logger.new("#{Detektiiv.configuration.logfile_path}")

      @logger.formatter = proc do |_severity, _datetime, _progname, msg|
        "#{msg}\n"
      end

      @logger
    end
  end
end
