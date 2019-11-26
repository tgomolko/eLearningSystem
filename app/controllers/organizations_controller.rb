class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy, :approve, :reject]
  before_action :authenticate_user!, :ensure_organiuzation_access, except: :show
  before_action :ensure_create_organization_more_then_one, only: :new

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
    @organization = current_user.build_organization
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = current_user.build_organization(organization_params)
    if @organization.save
      redirect_to @organization, notice: t(:org_created_successfully)
    else
      render :new
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    if @organization.update(organization_params)
      redirect_to @organization, notice: t(:org_updated_successfully)
    else
      render :edit
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    redirect_to organizations_url, notice: t(:org_destroyed_successfully)
  end

  def approve
    approve_service = OrganizationApproveService.new(@organization)
    if approve_service.approve_organization
      redirect_to admin_pending_org_path, notice: t(:org_aproved_successfully)
    else
      redirect_to admin_pending_org_path, alert: t(:org_already_approved)
    end
  end

  def reject
    approve_service = OrganizationApproveService.new(@organization)
    if approve_service.reject_organization
      redirect_to admin_pending_org_path, notice: t(:org_rejected_successfully)
    else
      redirect_to admin_pending_org_path, alert: t(:org_already_rejected)
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

  def ensure_create_organization_more_then_one
    if current_user.organization
      redirect_to root_path, alert: t(:only_one_organization)
    end
  end

  def ensure_organiuzation_access
    begin
      authorize @organization
    rescue
      redirect_to root_path, alert: t(:access_disable)
    end
  end
end
