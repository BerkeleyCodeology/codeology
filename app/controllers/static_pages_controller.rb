class StaticPagesController < ApplicationController
  def home
    render layout: 'application_fluid'
  end

  def calendar
  end

  def recruitment
    render 'recruitment'
  end
end
