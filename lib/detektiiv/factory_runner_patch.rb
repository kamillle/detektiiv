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

      trait_defined_filenames = @traits.map { |trait_name|
                                  FactoryBot
                                    .factory_by_name(@name)
                                    .instance_variable_get(:@definition)
                                    .instance_variable_get(:@defined_traits)
                                    .instance_variable_get(:@hash)
                                    .select { |i| i.instance_variable_get(:@name).to_s.include?(trait_name.to_s) }.first.first
                                }

      # return if factory_defined_filename.nil? || factory_defined_filename.to_s.include?("#{Detektiiv.configuration.application_name}/spec/factories")

      if factory_defined_filename.to_s.include?('definition_proxy')
        trait_defined_filenames.each do |trait_info|
          logger.debug(trait_name: trait_info.instance_variable_get(:@name), trait_defined_path: trait_info.instance_variable_get(:@block))
        end
        logger.debug(caller: caller.select { |i| i.include?("#{Detektiiv.configuration.application_name}/spec") })

        return
      end

      logger.debug(filepath: factory_defined_filename)
      logger.debug(caller: caller.select { |i| i.include?("#{Detektiiv.configuration.application_name}/spec") })
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
