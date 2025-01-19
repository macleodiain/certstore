class CertsController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]
  def index
    if user_signed_in?
      redirect_to dashboard_path
    end

  end

  def dashboard
    @certs = current_user.certs.sorted
  end

  def show

    begin
      @cert = current_user.certs.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      @cert = nil
    end
    if @cert.nil?
      redirect_to dashboard_path, alert: "Cert not found"
    end
  end

  def new
    @cert = Cert.new
  end

  def create
    @cert = Cert.new(cert_params)
    if @cert.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @cert = Cert.find(params[:id])
  end

  def update
    @cert = Cert.find(params[:id])
    if @cert.update(cert_params)
      redirect_to @cert
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @cert = Cert.find(params[:id])
    @cert.destroy
    redirect_to root_path
  end

  private
  def cert_params
    params.require(:cert).permit(:name, :image, :expires, :user_id)
  end
end
