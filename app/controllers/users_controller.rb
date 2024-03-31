class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy, :show]

  before_action :set_client, only: [:create, :verify, :update]
  before_action :current_user, only: [:verify]
  
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    
  end

  def edit
    
  end

  def create
    channel = user_params['channel']
    @user = User.new(user_params.except('channel', 'displayed_phone_number'))

    respond_to do |format|
      if @user.save
        start_verification(@user.full_phone_number, channel)
        session[:user_id] = @user.id
        format.html { redirect_to verify_url, notice: 'User was successfully created.' }
        # format.html { redirect_to users_url, notice: 'User was successfully created.' }
        format.json { render :index, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    channel = user_params['channel']
    respond_to do |format|
      if @user.update(user_params)
        @user.update(verified: false)
        start_verification(@user.full_phone_number, channel)
        session[:user_id] = @user.id
        # format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.html { redirect_to verify_url, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def verify
    if request.post?
      is_verified = check_verification(@current_user.full_phone_number, params['verification_code'])
      if is_verified
        @current_user.verified = true
        @current_user.save
        respond_to do |format|
          format.html { redirect_to users_path, notice: 'User was successfully verified.' }
        end
      else
        respond_to do |format|
          format.html { redirect_to verify_url, notice: 'The code was invalid.' }
        end
      end
    else
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_client
    @client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :country_code, :phone_number, :location, :city, :state, :country)
  end

  def start_verification(to, channel='sms')
    channel = 'sms' unless ['sms', 'voice'].include? channel
    verification = @client.verify.services(ENV['VERIFICATION_SID'])
                                 .verifications
                                 .create(:to => to, :channel => channel)
    return verification.sid
  end

  def check_verification(phone, code)
    verification_check = @client.verify.services(ENV['VERIFICATION_SID'])
                                       .verification_checks
                                       .create(:to => phone, :code => code)
    return verification_check.status == 'approved'
  end
end
