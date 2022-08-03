class ApplicationWorker
    class << self
        def perform(*args)
            new.perform(*args)
        end
    end
end