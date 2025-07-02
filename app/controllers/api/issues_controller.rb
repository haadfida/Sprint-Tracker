module Api
  class IssuesController < BaseController
    before_action :set_issue, only: %i[show update destroy]

    # GET /api/issues
    def index
      issues = current_company.issues.includes(:project, :sprint, :assignee, :creator)
      render json: issues
    end

    # GET /api/issues/:id
    def show
      render json: @issue
    end

    # POST /api/issues
    def create
      issue = current_company.issues.new(issue_params.merge(creator: current_user))

      if issue.save
        render json: issue, status: :created
      else
        render json: { errors: issue.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/issues/:id
    def update
      if @issue.update(issue_params)
        render json: @issue
      else
        render json: { errors: @issue.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # DELETE /api/issues/:id
    def destroy
      if @issue.destroy
        head :no_content
      else
        render json: { errors: @issue.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def set_issue
      @issue = current_company.issues.find(params[:id])
    end

    def issue_params
      params.require(:issue).permit(:title, :description, :status, :category, :estimated_time, :priority,
                                    :estimated_end_date, :estimated_start_date, :actual_start_date, :actual_end_date,
                                    :reviewer_id, :assignee_id, :project_id, :sprint_id)
    end
  end
end 