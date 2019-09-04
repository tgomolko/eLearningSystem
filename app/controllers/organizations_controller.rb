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
  def show
  end

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

    respond_to do |format|
      if @organization.save
        format.html { redirect_to @organization, notice: t(:org_created_successully) }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: t(:org_updated_successully) }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url, notice: t(:org_destroyed_successully) }
    end
  end

<<<<<<< HEAD
  def approve
    approve_service = OrganizationApproveService.new(@organization)
    respond_to do |format|
      if approve_service.approve_organization
        format.html { redirect_to admin_pending_org_path, notice: "Organization was successfully approved!" }
      else
        format.html { redirect_to admin_pending_org_path, alert: "Organization is already approved" }
      end
    end
  end

  def reject 
    approve_service = OrganizationApproveService.new(@organization)
    respond_to do |format|
      if approve_service.reject_organization
        format.html { redirect_to admin_pending_org_path, notice: "Organization was successfully rejected" }
      else
        format.html { redirect_to admin_pending_org_path, alert: "Organization is already rejected" }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_organization
    @organization = Organization.find(params[:id])
  end

=======
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_organization
    @organization = Organization.find(params[:id])
  end

>>>>>>> EL-4Organization
  # Never trust parameters from the scary internet, only allow the white list through.
  def organization_params
    params.require(:organization).permit(:company_name, :description, :user_id)
  end
end
