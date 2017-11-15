class LoansController < ApplicationController
  before_action :set_loan, only: [:show, :edit, :update, :destroy]

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
    @invester = User.find(current_user.id)
  end

  # GET /loans/new
  def new
    @loan = Loan.new
  end

  # GET /loans/1/edit
  def edit

    if @loan.save

      require 'dwolla_v2'

      customers = $dwolla.auths.client.get "customers"

      source = ""
      href = ""

      borrower = User.find(@loan.user.id)
      # Get borrower href
      customers._embedded.customers.each do |transfer|
        if transfer.email == borrower.email
          href = transfer._links.self.href
        end
      end

      
      invester = User.find(current_user.id)
      # Get lender source
      customers._embedded.customers.each do |transfer|
        if transfer.email == invester.email
          this_href = transfer._links.self.href
          
          customer_url = "#{this_href}/funding-sources"
          

          funding_source = $dwolla.auths.client.get customer_url
          source = funding_source._embedded['funding-sources'][0]._links.self.href
        end
      end

      request_body = {
        :_links => {
          :source => {
            :href => source
          },
          :destination => {
            :href => href
          }
        },
        :amount => {
          :currency => "USD",
          :value => "#{@loan.amount_in_cents/100}"
        },
        :metadata => {
          :paymentId => "12345678",
          :note => "ITS WORKINNGGGGGGG"
        },
        :clearing => {
          :destination => "next-available"
        },
        :correlationId => "8a2cdc8d-629d-4a24-98ac-40b735229fe2"
      }

      transfer = $dwolla.auths.client.post "transfers", request_body
    end
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def loan_params
      params.require(:loan).permit(:amount_in_cents, :body, :status, :lender_id)
    end
end
