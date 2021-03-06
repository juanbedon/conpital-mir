class ExpensesController < ApplicationController

  def index

    if params["transaction_type"] && !params["category"]
      @expenses = current_user.expenses.joins(:transaction_type).where("transaction_types.name = ?", params["transaction_type"].capitalize)
    elsif params["category"] && !params["transaction_type"]
      @expenses = current_user.expenses.joins(:category).where("categories.name = ?", params["category"].capitalize)
    elsif params["category"] && params["transaction_type"]
      @expenses = current_user.expenses.joins(:transaction_type, :category).where("transaction_types.name = ? AND categories.name = ?",
      params["transaction_type"].capitalize, params["category"].capitalize)
    else
      @expenses = current_user.expenses
    end

    if params["current_month"]
      @expenses = current_user.expenses.where(date: 0.months.ago.all_month)
    elsif params["month_ago"]
      @expenses = current_user.expenses.where(date: 1.month.ago.all_month)
    elsif params["two_months_ago"]
      @expenses = current_user.expenses.where(date: 2.months.ago.all_month)
    elsif params["three_months_ago"]
      @expenses = current_user.expenses.where(date: 3.months.ago.all_month)
    elsif params["four_months_ago"]
      @expenses = current_user.expenses.where(date: 4.months.ago.all_month)
    elsif params["five_months_ago"]
      @expenses = current_user.expenses.where(date: 5.months.ago.all_month)
    elsif params["six_months_ago"]
      @expenses = current_user.expenses.where(date: 6.months.ago.all_month)
    elsif params["seven_months_ago"]
      @expenses = current_user.expenses.where(date: 7.months.ago.all_month)
    elsif params["eight_months_ago"]
      @expenses = current_user.expenses.where(date: 8.months.ago.all_month)
    elsif params["nine_months_ago"]
      @expenses = current_user.expenses.where(date: 9.months.ago.all_month)
    elsif params["ten_months_ago"]
      @expenses = current_user.expenses.where(date: 10.months.ago.all_month)
    elsif params["eleven_months_ago"]
      @expenses = current_user.expenses.where(date: 11.months.ago.all_month)
    elsif params["twelve_months_ago"]
      @expenses = current_user.expenses.where(date: 12.months.ago.all_month)
    end

  end

  def show
    @expense = current_user.expenses.find(params[:id])
  end

  def new
    @expense = current_user.expenses.new
  end

  def create
    @expense = current_user.expenses.create(expense_params.merge(user_id: current_user.id))
  end

  def edit
    @expense = current_user.expenses.find(params[:id])
  end

  def update

    @expense = current_user.expenses.find(params[:id])
    @expense.update_attributes(expense_params)

    redirect_to expenses_path, notice: "Your expense was updated!"

  end

  def destroy

    @expense = current_user.expenses.find(params[:id])
    @expense.destroy

    redirect_back fallback_location: expenses_path, notice: "Your expense was removed!"

  end


  private

    def expense_params
      params.require(:expense).permit(:transaction_type_id, :date, :concept, :category_id, :amount).merge(user_id: current_user.id)
    end

end