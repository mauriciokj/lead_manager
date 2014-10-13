class LeadsController < ApplicationController
  require 'rd_challenge'
  before_action :authenticate_user!
  before_action :set_lead, only: [:show, :edit, :update, :destroy]
  before_action :set_salesforce_config, only: [:update, :destroy]
  before_filter do 
    redirect_to salesforce_configuration_path unless current_user.salesforce_configuration
  end

  # GET /leads
  # GET /leads.json
  def index
    @leads = current_user.leads
  end

  # GET /leads/1
  # GET /leads/1.json
  def show
  end

  # GET /leads/new
  def new
    @lead = Lead.new
  end

  # GET /leads/1/edit
  def edit
  end

  # POST /leads
  # POST /leads.json
  def create
    @lead = current_user.leads.new(lead_params)
    set_salesforce_config

    respond_to do |format|
      if @lead.save
        save_on_salesforce
        format.html { redirect_to @lead, notice: 'Lead was successfully created.' }
        format.json { render :show, status: :created, location: @lead }
      else
        format.html { render :new }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leads/1
  # PATCH/PUT /leads/1.json
  def update
    respond_to do |format|
      if @lead.update(lead_params)
        save_on_salesforce
        
        format.html { redirect_to @lead, notice: 'Lead was successfully updated.' }
        format.json { render :show, status: :ok, location: @lead }
      else
        format.html { render :edit }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leads/1
  # DELETE /leads/1.json
  def destroy
    destroy_on_salesforce
    @lead.destroy
    respond_to do |format|
      format.html { redirect_to leads_url, notice: 'Lead was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lead
      @lead = current_user.leads.find(params[:id])
    end

    def set_salesforce_config
      @lead.authenticate do |auth|
        auth.client_id = current_user.salesforce_configuration.client_id
        auth.client_secret = current_user.salesforce_configuration.client_secret
        auth.username = current_user.salesforce_configuration.username
        auth.password = current_user.salesforce_configuration.password
        auth.security_token = current_user.salesforce_configuration.security_token
      end
    end

    def destroy_on_salesforce
      @lead.destroy_on_sales_force(@lead.sales_force_id)
    end

    def save_on_salesforce
      RdChallenge::Run.setup do |attribute|
        attribute.FirstName = @lead.first_name
        attribute.LastName = @lead.last_name
        attribute.Email = @lead.email
        attribute.Phone = @lead.phone
        attribute.Company = @lead.company
        attribute.Tittle = @lead.tittle
        attribute.Website = @lead.website
        attribute.Id = @lead.sales_force_id
      end
      sale_force_id = @lead.save_on_sales_force
      @lead.update(:sales_force_id => sale_force_id) unless @lead.sales_force_id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lead_params
      params.require(:lead).permit(:first_name, :last_name, :email, :phone, :company, :tittle, :website)
    end
end
