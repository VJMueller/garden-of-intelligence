class PlantsController < ApplicationController
  def index
    begin
      ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"])
      @connection_success = true

      connection = ActiveRecord::Base.connection
      @adapter = connection.adapter_name || nil
      @database_name = connection.current_database || nil
      @database_version = connection.raw_connection.server_version || nil
      @host = connection.host || nil
      @port = connection.port || nil
      @username = connection.raw_connection.user || nil
      @current_user = connection.raw_connection.username || nil
    rescue ActiveRecord::NoDatabaseError, ActiveRecord::StatementInvalid => e
      @connection_success = false
      @error_message = e.message
    end
  end
end
