require 'pstore'

module DasCatalog
  class Store
    def self.find(id)
      store = PStore.new(DasCatalog.tracker_file)
      store.transaction(true) do
        store[id]
      end
    end

    def self.store(screencast_data)
      store = PStore.new(DasCatalog.tracker_file)
      store.transaction do
        store[screencast_data.id] = screencast_data
      end
    end
  end
end
