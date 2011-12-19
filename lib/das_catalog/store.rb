require 'pstore'

module DasCatalog
  module Store
    class UUIDMismatch < StandardError; end

    extend self

    def pstore
      @pstore ||= PStore.new(DasCatalog.tracker_file)
    end

    def reset
      pstore.transaction do
        pstore.roots.each do |key|
          pstore.delete key
        end
      end
    end

    def find(id)
      pstore.transaction(true) do
        pstore[id]
      end
    end

    def all
      pstore.transaction(true) do
        pstore.roots.collect do |name|
          pstore[name]
        end
      end
    end

    def store(screencast_data)
      if sd = find(screencast_data.id)
        raise UUIDMismatch if sd.uuid && sd.uuid != screencast_data.uuid
      end

      pstore.transaction do
        pstore[screencast_data.id] = screencast_data
      end
    end
  end
end
