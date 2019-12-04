class OrganizationsController < ApplicationController
  before_action :set_organization, except: [:index, :new, :create]
  before_action :authenticate_user!, except: :show
  before_action :ensure_create_organization_more_then_one, only: :new
  before_action :ensure_organiuzation_access, only: :edit

  def index
    @organizations = Organization.all
  end

  def show ; end

  def new
    @organization = current_user.build_organization
  end

  def create
    @organization = current_user.build_organization(organization_params)
    if @organization.save
      redirect_to @organization, notice: t(:org_created_successfully)
    else
      render :new
    end
  end

  def update
    if @organization.update(organization_params)
      redirect_to @organization, notice: t(:org_updated_successfully)
    else
      render :edit
    end
  end

  def destroy
    @organization.destroy
    redirect_to organizations_url, notice: t(:org_destroyed_successfully)
  end

  def approve
    if OrganizationApproveService.new(@organization).approve
      redirect_to admin_pending_org_path, notice: t(:org_aproved_successfully)
    else
      redirect_to admin_pending_org_path, alert: t(:org_already_approved)
    end
  end

  def reject
    if OrganizationApproveService.new(@organization).reject
      redirect_to admin_pending_org_path, notice: t(:org_rejected_successfully)
    else
      redirect_to admin_pending_org_path, alert: t(:org_already_rejected)
    end
  end

  private

  def set_organization
    @organization = Organization.find(params[:id])
  end

  def organization_params
    params.require(:organization).permit(:company_name, :description, :user_id)
  end

  def ensure_create_organization_more_then_one
    redirect_to root_path, alert: t(:only_one_organization) if current_user.organization
  end

  def ensure_organiuzation_access
    authorize @organization
  rescue
    redirect_to root_path, alert: t(:access_disable)
  end
end
