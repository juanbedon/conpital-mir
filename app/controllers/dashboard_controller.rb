class DashboardController < ApplicationController

  def index
    @handler = DashboardHandler.new(current_user.expenses)
    @amount_of_today = @handler.amount_of_today
    @amount_of_yesterday = @handler.amount_of_yesterday
    @amount_of_current_month = @handler.amount_of_current_month
    @amount_of_last_month = @handler.amount_of_last_month
  end
  
end