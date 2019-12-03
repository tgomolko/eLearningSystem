class BuildCourseParams
  attr_reader :current_user, :params

  def initialize(current_user, params)
    @current_user = current_user
    @params = params
  end

  def call
    if params[:access_state] == "Public"
      params[:organization_id] = nil
    else
      params.merge!(organization_id: current_user.organization_id || current_user.participant_org_id)
    end
    params
  end
end
