class PhotoPolicy <ApplicationController
    attr_reader :user, :photo

  def initialize(user, photo)
    puts "asdsadfdsfdsfdsfdf#########"
    @user = user
    @photo = photo
  end

  def index?
    user.id==100
  end
end