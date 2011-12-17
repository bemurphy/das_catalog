require 'logger'
require 'delegate'

module DasCatalog
  class StdLogger < DelegateClass(::Logger)
    def initialize
      @logger = ::Logger.new(STDOUT)
      super(@logger)
    end
  end

  module LoggerAccess
    def self.included(klass)
      klass.extend(self)
    end

    def log
      DasCatalog.logger
    end
  end
end
