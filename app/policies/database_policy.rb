class DatabasePolicy < ApplicationPolicy
    def index?
        user.admin? 
    end
end