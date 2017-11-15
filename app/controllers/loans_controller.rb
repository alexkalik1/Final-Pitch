class LoansController < ApplicationController
  before_action :set_loan, only: [:show, :edit, :update, :destroy, :repay]
  after_action :http_request, only: :update

  # GET /loans
  # GET /loans.json
  def index
    @loans = Loan.all
    # @user = User.find(params[:id])
    @all_loans = User.find(current_user.id).loans
    @p_count = 0 #count of pending loans
    @a_count = 0 #count of active loans
    @c_count = 0 #count of completed loans
    @loans.each do |pending|
      if pending.status == "Pending"
        @p_count = @p_count + 1
      end
    end

    @all_loans.each do |pending|
      if pending.status == "Active"
        @a_count = @a_count + 1
      end
    end

    @all_loans.each do |pending|
      if pending.status == "Completed"
        @c_count = @c_count + 1
      end
    end

  end

  # GET /loans/1
  # GET /loans/1.json
  def show
    @invester = User.find(@loan.user.id)
  end

  # GET /loans/new
  def new
    @loan = Loan.new
  end

  # GET /loans/1/edit
  def edit

  end

  def repay

  end

  # POST /loans
  # POST /loans.json
  def create
    @user = User.find(current_user.id)
    @loan = @user.loans.new(loan_params)

    respond_to do |format|
      if @loan.save
        format.html { redirect_to @loan, notice: 'Loan was successfully created.' }
        format.json { render :show, status: :created, location: @loan }
      else
        format.html { render :new }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /loans/1
  # PATCH/PUT /loans/1.json
  def update
    respond_to do |format|
      if @loan.update(loan_params)
        format.html { redirect_to @loan, notice: 'Loan was successfully updated.' }
        format.json { render :show, status: :ok, location: @loan }
      else
        format.html { render :edit }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loans/1
  # DELETE /loans/1.json
  def destroy
    @loan.destroy
    respond_to do |format|
      format.html { redirect_to loans_url, notice: 'Loan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loan
      @loan = Loan.find(params[:id])
    end

    def http_request
      redirect_to :back, notice: "Payment Failed" and return unless @loan.save
      client = Dwolla.new
      borrower = User.find(@loan.user.id)
      invester = User.find(@loan.lender_id)

      if current_user.role == "Lender"

        # Get borrower href
        to = client.find_url(borrower.email)
        # Get lender source
        from = client.find_funding_source_url(invester.email)

        amount = "#{@loan.amount_in_cents/100}"

      elsif current_user.role == "Borrower" && @loan.status == "Closed"

        # Get borrower href
        from = client.find_funding_source_url(borrower.email)
        # Get lender source
        to = client.find_url(invester.email)

        amount = "#{((@loan.amount_in_cents/100) * 1.05)}"

      end
      client.send_money(from, to, amount)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def loan_params
      params.require(:loan).permit(:amount_in_cents, :body, :status, :lender_id)
    end
end
