class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # before_action :check_user, only: [:show]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @lender_loans = Loan.where(lender_id: @user)
    @p_count = 0 #count of pending loans
    @a_count = 0 #count of active loans
    @c_count = 0 #count of completed loans

    @lender_loans.each do |pending|
      if pending.status == "Pending"
        @p_count = @p_count + 1
      end
    end

    @lender_loans.each do |active|
      if active.status == "Active"
        @a_count = @a_count + 1
      end
    end

    @lender_loans.each do |completed|
      if completed.status == "Completed"
        @c_count = @c_count + 1
      end
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    return render action: 'new' unless @user.save

    client = Dwolla.new

    first_name = @user.first_name
    last_name = @user.last_name
    email = @user.email
    type = "personal"
    address = @user.address
    city = @user.city
    state = @user.state
    postal_code = @user.postal_code
    date_of_birth = @user.date_of_birth
    last_four_of_ssn = @user.last_four_of_ssn

    client.create_customer(first_name, last_name, email, type, address, city, state, postal_code, date_of_birth, last_four_of_ssn)
    redirect_to user_path(@user), notice: 'Created user'
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # def check_user
    #   if current_user.id != @user
    #     redirect_to root_path
    #   end
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :role, :username, :password, :password_confirmation, :address, :city, :state, :postal_code, :date_of_birth, :last_four_of_ssn)
    end
end
