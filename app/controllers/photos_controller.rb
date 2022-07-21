class PhotosController < ApplicationController
  
  def index
    @photos = Photo.all

  end

  def show
    
  end

  def welcome
  end
end
