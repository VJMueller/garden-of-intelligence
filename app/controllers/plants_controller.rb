class PlantsController < ApplicationController
  def index
    begin
      ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"])
      @connection_success = true

      connection = ActiveRecord::Base.connection
      @adapter = connection&.adapter_name
      @database_name = connection&.current_database
      @database_version = connection&.raw_connection&.server_version
      #@host = connection&.host
      #@port = connection&.port
      #@username = connection&.raw_connection&.user
      #@current_user = connection&.raw_connection&.username
    rescue ActiveRecord::NoDatabaseError, ActiveRecord::StatementInvalid => e
      @connection_success = false
      @error_message = e.message
    end
  end
end
