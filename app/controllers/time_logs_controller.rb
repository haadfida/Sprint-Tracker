class TimeLogsController < ApplicationController
  load_and_authorize_resource :issue, find_by: :sequence_num
  load_and_authorize_resource find_by: :sequence_num, through: :issue

  # GET /time_logs or /time_logs.json
  def index
    @time_logs = @time_logs.paginate(page: params[:page])
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /time_logs/1 or /time_logs/1.json
  def show
    respond_to do |format|
      format.js
    end
  end

  # GET /time_logs/new
  def new
    respond_to do |format|
      format.js
    end
  end

  # GET /time_logs/1/edit
  def edit
    respond_to do |format|
      format.js
    end
  end


  # POST /time_logs
  def create

    #@time_log = TimeLog.new(time_log_params)
    @time_log.assignee_id = current_user.id
    #@time_log.issue_id = @issue.id

    respond_to do |format|
      if @time_log.save
        format.js { flash.now[:notice] = t('shared.success.create', resource_label: t('time_logs.label')) }
      else
        format.js do
          flash.now[:error] = @time_log.errors.full_messages
          flash.now[:error] << t('shared.failure.create', resource_label: t('time_logs.label'))
        end
      end
    end
  end

  # PATCH/PUT /time_logs/1 or /time_logs/1.json
  def update
    respond_to do |format|
      if @time_log.update(time_log_params)
        format.js { flash.now[:notice] = t('shared.success.update', resource_label: t('time_logs.timelogs_label')) }
      else
        flash.now[:error] = @time_log.errors.full_messages
        flash.now[:error] << t('shared.failure.create', resource_label: t('time_logs.label'))
      end
    end
  end

  # DELETE /time_logs/1 or /time_logs/1.json
  def destroy
    respond_to do |format|
      if @time_log.destroy
        format.js { flash.now[:notice] = t('shared.success.delete', resource_label: t('time_logs.label')) }
      else
        format.js { flash.now[:notice] = t('shared.failure.delete', resource_label: t('time_logs.label')) }
      end
    end
  end

  private

  def time_log_params
    params.require(:time_log).permit(:name, :date, :logged_time, :work_description)
  end
end
