Rails.application.configure do
    console do
      PaperTrail.request.whodunnit = ENV.fetch('USER') 
    end
end