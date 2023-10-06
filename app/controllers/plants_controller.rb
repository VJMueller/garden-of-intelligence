class PlantsController < ApplicationController
  def index
    begin
      ActiveRecord::Base.connection.execute('SELECT 1')
      @connection_success = true
    rescue ActiveRecord::NoDatabaseError, ActiveRecord::StatementInvalid => e
      @connection_success = false
      @error_message = e.message
    end
  end
end
