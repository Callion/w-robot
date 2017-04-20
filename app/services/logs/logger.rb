# frozen_string_literal: true
module Logs
  class Logger
    attr_reader :automation
    def initialize(automation)
      @automation = automation
    end

    def conserve
      log_creation
    end

    private

    def log_creation
      log = Log.create(user_id: automation.user_id)
      log.message = if automation_is_valid?
                      automation_description + 'was successfully executed'
                    else
                      automation_description + 'has failed with ' + procedure_description
                    end
      log.save
    end

    def automation_is_valid?
      @invalid_procedure ||= automation.procedures.where(broken: true).take
      !@invalid_procedure.present?
    end

    def automation_description
      "Automation (name: #{automation.name}, ID: #{automation.id}) "
    end

    def procedure_description
      "procedure (name: #{@invalid_procedure.name.presence || '--'}, position: #{@invalid_procedure.position})"
    end
  end
end
