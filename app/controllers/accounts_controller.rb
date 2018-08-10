class AccountsController < ApplicationController
  skip_before_action :authenticate_request
  before_action :set_account, only: [:show, :update, :destroy]

  # GET /accounts
  def index
    @accounts = Account.all

    render json: @accounts
  end

  # GET /accounts/1
  def show
    render json: @account
  end

  # POST /accounts
  def create
    @account = Account.new(account_params)
    user_params = params["account"]
    user_params = ::UserParams.remove_account_details(account_params, user_params)
    if @account.save
      ::SwitchTenant.switch_subdomain(@account.subdomain)
      User.create_admin(user_params)
      render json: @account, status: :created, location: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  def set_subdomain
    @subdomain = params["user"]["name"].downcase
    @account = Account.find_account(@subdomain)
    if @account
      ::SwitchTenant.switch_subdomain(@subdomain)
      render json: { subdomain: @account.subdomain, account: { name: @account.name, status: {msg: "Successfully logged in to work space", info: "Success"} } }
    else
      render json: {errors: {msg:["Invalid work space"]}, action: "SET_SUBDOMAIN"} , status: :unauthorized
    end
  end
  # PATCH/PUT /accounts/1
  def update
    if @account.update(account_params)
      render json: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # DELETE /accounts/1
  def destroy
    @account.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end
    # Only allow a trusted parameter "white list" through.
    def account_params
      params.require(:account).permit(:subdomain, :name, :description)
    end
end
