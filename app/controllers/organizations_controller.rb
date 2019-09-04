class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy, :approve, :reject]
  before_action :authenticate_user!

  # GET /organizations
  # GET /organizations.json
  def index
    @organizations = Organization.all
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show ; end

  # GET /organizations/new
  def new
    @organization = current_user.organizations.build
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = current_user.organizations.build(organization_params)
    if @organization.save
      redirect_to @organization, notice: t(:org_created_successully)
    else
      render :new 
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update   
    if @organization.update(organization_params)
      redirect_to @organization, notice: t(:org_updated_successully)
    else
      render :edit
    end  
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    redirect_to organizations_url, notice: t(:org_destroyed_successully)
  end

  def approve
    approve_service = OrganizationApproveService.new(@organization)
    respond_to do |format|
      if approve_service.approve_organization
        format.html { redirect_to admin_pending_org_path, notice: t(:org_aproved_successully) }
      else
        format.html { redirect_to admin_pending_org_path, alert: t(:org_already_approved) }
      end
    end
  end

  def reject 
    approve_service = OrganizationApproveService.new(@organization)
    respond_to do |format|
      if approve_service.reject_organization
        format.html { redirect_to admin_pending_org_path, notice: t(:org_rejected_successully) }
      else
        format.html { redirect_to admin_pending_org_path, alert: t(:org_already_rejected) }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_organization
    @organization = Organization.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def organization_params
    params.require(:organization).permit(:company_name, :description, :user_id)
  end
end
