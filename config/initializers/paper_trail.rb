Rails.application.configure do
    console do
      PaperTrail.request.whodunnit = ENV.fetch('USER', nil) 
    end
end