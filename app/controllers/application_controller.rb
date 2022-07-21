class ApplicationController < ActionController::Base
    include Pundit

    before_action :authenticate_user!
    before_action :set_paper_trail_whodunnit

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private
    def user_not_authorized
        flash[:alert] = 'Access denied!!!'
        respond_to do |format|
          format.html { redirect_to :root }
          format.json { render json: {redirect: root_path}, status: 403 }
        end
      end

    end
