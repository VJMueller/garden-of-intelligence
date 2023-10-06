class DatabaseInfoController < ApplicationController
    def show
        begin
            ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"])
            @connection = ActiveRecord::Base.connection
            @connection_success = true
            @connection_config = ActiveRecord::Base.connection_config
            @adapter = ActiveRecord::Base.connection.adapter_name
            @database_name = ActiveRecord::Base.connection.current_database
            @database_version = ActiveRecord::Base.connection.raw_connection.server_version
            # Add more details as needed
        rescue ActiveRecord::NoDatabaseError, ActiveRecord::StatementInvalid => e
            @connection_success = false
            @error_message = e.message
        end
    end
end
