class CertsController < ApplicationController
  before_action :authenticate_user!
  def index
    @certs = Cert.sorted
  end

  def show
    @cert = Cert.find(params[:id])
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
    params.require(:cert).permit(:name, :image, :expires)
  end
end
