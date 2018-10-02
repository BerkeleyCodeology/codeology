class AvailabilitiesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :redirect_to_login
  before_action :logged_in_user, only: [:index]
  before_action :correct_user,   only: [:destroy]
    
    def index
      @curr_user = User.find(session[:user_id])
      @allUpcomingReceiving = Upcoming_interview.where(interviewee: session[:user_id]).order('time ASC')
      @allUpcomingGiving = Upcoming_interview.where(interviewer: session[:user_id]).order('time ASC')
      render layout: 'web_application'
    end
   
    def destroy
      Upcoming_interview.find(params[:id]).destroy
      flash.now[:success] = "Interview cancelled"
      redirect_to upcoming_interviews_path
    end
  
    private
  
      def redirect_to_login
        redirect_to login_path
      end
        
      # Before filters
  
      # Confirms a logged-in user.
      def logged_in_user
        unless user_is_logged_in?
          flash[:warning] = "Please log in."
          redirect_to login_url
        end
      end
  
      # Confirms the correct user or user is admin
      def correct_user
        @user = User.find(@availability.user_id)
        unless (current_user?(@user) || is_admin?)
          flash[:warning] = "You do not have authorization."        
          redirect_to dashboard_path 
        end
      end
  end