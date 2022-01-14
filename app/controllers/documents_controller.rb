class DocumentsController < ApplicationController
  load_and_authorize_resource :sprint, find_by: :sequence_num, instance_name: :attachable, if: -> { params[:sprint_id].present? }
  load_and_authorize_resource :issue, find_by: :sequence_num, instance_name: :attachable, if: -> { params[:issue_id].present? }
  load_and_authorize_resource :document, through: :attachable

  def index
    respond_to do |format|
      format.js
    end
  end

  def new
    respond_to do |format|
      format.js
    end
  end

  def create
    respond_to do |format|
      if @document.save
        format.js { flash.now[:notice] = t('shared.success.add', resource_label: t('documents.label')) }
      else
        format.js { flash.now[:error] = @document.errors.full_messages }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @document.destroy
        format.js { flash.now[:notice] = t('shared.success.delete', resource_label: t('documents.label')) }
      else
        format.js { flash.now[:error] = @document.errors.full_messages }
      end
    end
  end

  private

  def document_params
    params.require(:document).permit(:file)
  end
end
