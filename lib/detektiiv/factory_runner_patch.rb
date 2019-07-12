module Detektiiv
  module FactoryRunnerPatch
    LOGGER = Logger.new("#{Detektiiv.configuration.logfile_path}")

    def run
      logging
      super
    end

    private

    def logging
      factory_defined_filename = FactoryBot
                                  .factory_by_name(@name)
                                  .instance_variable_get(:@definition)
                                  .instance_variable_get(:@declarations)
                                  .instance_variable_get(:@declarations)[0]
                                  .instance_variable_get(:@block)


      if factory_defined_filename&.to_s&.include?("#{Detektiiv.configuration.application_name}/spec/factories") || factory_defined_filename&.to_s&.include?('factory_bot') || factory_defined_filename.nil?
        return
      else
        LOGGER.debug(factory_defined_filename)
        LOGGER.debug(caller: caller.select {|i| i.include?("#{Detektiiv.configuration.application_name}/spec") }.to_s)
      end
    end
  end
end
