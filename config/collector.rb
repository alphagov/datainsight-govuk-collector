require "airbrake"
require_relative "../lib/govuk_collector"
require_relative "../config/initializers/errbit"

module DataInsight
  module Collector
    def self.options
      {
         url: "URL of artefacts json",
        formats: "list of formats to collect, comma separated"
      }
    end

    def self.collector(arguments)
      GovUkCollector.new(arguments[:url], arguments[:formats].split(',').map(&:strip))
    end

    def self.queue_name(arguments)
      "datainsight"
    end

    def self.queue_routing_key(arguments)
      "govuk.artefacts"
    end

    def self.handle_error(error)
      Airbrake.notify(error)
    end

  end
end