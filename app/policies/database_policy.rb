class DatabasePolicy < ApplicationPolicy
    def show?
        user.admin? 
    end
end