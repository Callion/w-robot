# frozen_string_literal: true
# Documentation comment
require 'watir/extensions/select_text'

class AutomationsController < ApplicationController
  before_action :set_automation, only: [:edit, :update, :destroy]

  DEFAULT_TIMEOUT = 5

  def index
    @automations = Automation.all.where(user_id: current_user.id)
  end

  def new
    @automation = Automation.new
  end

  def edit; end

  def execute
    automation = Automation.find(params[:automation_id])
    unless automation.data.present?
      return redirect_to automations_path(@automations),
                         alert: 'Automation wasn\'t executed.'
    end
    browser = Html::Browser.new(timeout: DEFAULT_TIMEOUT, type: automation.browser_type).object
    automation.data.each do |procedure|
      handler_was_not_working
      begin
        eval('browser.' + procedure.script)
      rescue
        handler(procedure, automation)
        break
      end
      procedure.update(broken: false) unless handler_worked?
    end
    browser.close if browser.present?
    if automation.errors.any?
      redirect_to edit_automation_path(automation), alert: form_errors(automation.errors)
    else
      redirect_to automations_path(@automations), notice: 'Automation was successfully executed.'
    end
  end

  def create
    @automation = Automation.new(automation_params)
    @automation.set_user(current_user)
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

  def handler(procedure, automation)
    procedure.update(broken: true)
    automation.errors.add(:procedure, "Procedure at #{procedure.position}. position failed!")
    handler_was_working
  end

  def set_automation
    @automation = Automation.find(params[:id])
  end

  def automation_params
    params.require(:automation).permit(:name, :active, :data, :browser_type, :user_id,
                                       procedures_attributes: [:id,
                                                               :automation_id,
                                                               :position,
                                                               :script,
                                                               :_destroy])
  end

  def handler_was_working
    @handler_worked ||= true
  end

  def handler_was_not_working
    @handler_worked ||= false
  end

  def handler_worked?
    @handler_worked
  end
end
