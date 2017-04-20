# frozen_string_literal: true
# Documentation comment
class AutomationsController < ApplicationController
  before_action :set_automation, only: [:edit, :update, :destroy]
  after_action :end_execute, only: :execute

  def index
    @automations = current_user.automations
  end

  def new
    @automation = Automation.new
  end

  def edit; end

  def execute
    automation = current_user.automations.find(params[:automation_id])
    browser = Html::BrowserBuilder.new(automation.browser_type).build
    @executor = Automations::Executor.new(automation, browser)

    if @executor.run
      redirect_to automations_path, notice: 'Automation was successfully executed.'
    else
      procedure = automation.procedures.where(broken: true).first
      redirect_to edit_automation_path(automation), alert: "Procedure at #{procedure.position}. position failed!"
    end
    Logs::Logger.new(automation).conserve
  end

  def create
    @automation = current_user.automations.new(automation_params)
    respond_to do |format|
      if @automation.save
        format.html { redirect_to edit_automation_path(@automation), notice: 'Automation was successfully created.' }
        format.json { render :edit, status: :created, location: @automation }
      else
        format.html { render :new }
        format.json { render json: @automation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @automation.update(automation_params)
        format.html do
          redirect_to edit_automation_path(@automation),
                      notice: 'Automation was successfully updated.'
        end
        format.json { render :edit, status: :ok, location: @automation }
      else
        format.html { render :edit }
        format.json do
          render json: @automation.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @automation.destroy
    respond_to do |format|
      format.html do
        redirect_to automations_url,
                    notice: 'Automation was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  def set_automation
    @automation = current_user.automations.find(params[:id])
  end

  def end_execute
    @executor.close_browser
  end

  def automation_params
    params.require(:automation).permit(:name, :active, :data, :browser_type, :repetition, :execute_at, :user_id,
                                       procedures_attributes: [:id,
                                                               :automation_id,
                                                               :name,
                                                               :position,
                                                               :category,
                                                               :path,
                                                               :selector,
                                                               :action,
                                                               :input,
                                                               :fill_into,
                                                               :_destroy])
  end
end
