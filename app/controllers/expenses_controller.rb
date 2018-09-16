class ExpensesController < ApplicationController

  def index

    transaction_type = params["transaction_type"]
    category = params["category"]

    if transaction_type && !category
      @expenses = Expense.joins(:transaction_type).where("transaction_types.name = ?", transaction_type.capitalize)
    elsif category && !transaction_type
      @expenses = Expense.joins(:category).where("categories.name = ?", category.capitalize)
    elsif category && transaction_type
      @expenses = Expense.joins(:transaction_type, :category).where("transaction_types.name = ? AND categories.name = ?",
      transaction_type.capitalize, category.capitalize)
    else
      @expenses = current_user.expenses
    end

    @transaction_types = TransactionType.all
    @category = Category.all;

    current_month = params["current_month"]
    month_ago = params["month_ago"]
    two_months_ago = params["two_months_ago"]
    three_months_ago = params["three_months_ago"]
    four_months_ago = params["four_months_ago"]
    five_months_ago = params["five_months_ago"]
    six_months_ago = params["six_months_ago"]
    seven_months_ago = params["seven_months_ago"]
    eight_months_ago = params["eight_months_ago"]
    nine_months_ago = params["nine_months_ago"]
    ten_months_ago = params["ten_months_ago"]
    eleven_months_ago = params["eleven_months_ago"]
    twelve_months_ago = params["twelve_months_ago"]

    if current_month
      @expenses = Expense.where(date: 0.months.ago.all_month)
    elsif month_ago
      @expenses = Expense.where(date: 1.month.ago.all_month)
    elsif two_months_ago
      @expenses = Expense.where(date: 2.months.ago.all_month)
    elsif three_months_ago
      @expenses = Expense.where(date: 3.months.ago.all_month)
    elsif four_months_ago
      @expenses = Expense.where(date: 4.months.ago.all_month)
    elsif five_months_ago
      @expenses = Expense.where(date: 5.months.ago.all_month)
    elsif six_months_ago
      @expenses = Expense.where(date: 6.months.ago.all_month)
    elsif seven_months_ago
      @expenses = Expense.where(date: 7.months.ago.all_month)
    elsif eight_months_ago
      @expenses = Expense.where(date: 8.months.ago.all_month)
    elsif nine_months_ago
      @expenses = Expense.where(date: 9.months.ago.all_month)
    elsif ten_months_ago
      @expenses = Expense.where(date: 10.months.ago.all_month)
    elsif eleven_months_ago
      @expenses = Expense.where(date: 11.months.ago.all_month)
    elsif twelve_months_ago
      @expenses = Expense.where(date: 12.months.ago.all_month)
    end

  end

  def show
    @expense = Expense.find(params[:id])
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.create(expense_params.merge(user_id: current_user.id))
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def update

    @expense = Expense.find(params[:id])
    @expense.update_attributes(expense_params)

    redirect_to expenses_path, notice: "Your expense was updated!"

  end

  def destroy

    @expense = Expense.find(params[:id])
    @expense.destroy

    redirect_back fallback_location: expenses_path, notice: "Your expense was removed!"

  end


  private

    def expense_params
      params.require(:expense).permit(:transaction_type_id, :date, :concept, :category_id, :amount).merge(user_id: current_user.id)
    end

end