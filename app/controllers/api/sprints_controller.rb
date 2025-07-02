module Api
  class SprintsController < BaseController
    before_action :set_sprint, only: %i[show update destroy]

    # GET /api/sprints
    # Optionally filter by project_id param
    def index
      scope = current_company.sprints.includes(:project)
      scope = scope.where(project_id: params[:project_id]) if params[:project_id]
      render json: scope
    end

    # GET /api/sprints/:id
    def show
      render json: @sprint
    end

    # POST /api/sprints
    def create
      sprint = current_company.sprints.new(sprint_params.merge(creator: current_user))

      if sprint.save
        render json: sprint, status: :created
      else
        render json: { errors: sprint.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/sprints/:id
    def update
      if @sprint.update(sprint_params)
        render json: @sprint
      else
        render json: { errors: @sprint.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # DELETE /api/sprints/:id
    def destroy
      if @sprint.destroy
        head :no_content
      else
        render json: { errors: @sprint.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def set_sprint
      @sprint = current_company.sprints.find(params[:id])
    end

    def sprint_params
      params.require(:sprint).permit(:name, :description, :start_date, :end_date, :estimated_start_date, :estimated_end_date, :project_id, :status)
    end
  end
end 