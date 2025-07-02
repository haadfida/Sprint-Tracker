module Api
  class ProjectsController < BaseController
    before_action :set_project, only: %i[show update destroy]

    # GET /api/projects
    def index
      projects = current_company.projects.includes(:issues)
      render json: projects
    end

    # GET /api/projects/:id
    def show
      render json: @project
    end

    # POST /api/projects
    def create
      project = current_company.projects.new(project_params)
      project.creator = current_user
      project.manager ||= current_user

      if project.save
        render json: project, status: :created
      else
        render json: { errors: project.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/projects/:id
    def update
      if @project.update(project_params.merge(manager_id: project_params[:manager_id] || @project.manager_id))
        render json: @project
      else
        render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # DELETE /api/projects/:id
    def destroy
      if @project.destroy
        head :no_content
      else
        render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def set_project
      @project = current_company.projects.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :start_date, :end_date, :manager_id)
    end
  end
end 