class PlantPolicy < ApplicationPolicy
    def index?
        member_or_admin? 
    end

    def show?
        member_or_admin?
    end

    def new?
        user.admin?
    end

    def create?
        new?
    end
    
    def update?
        user.admin?
    end

    def destroy?
        user.admin?
    end

    private 
    
    def member_or_admin?
        user.admin? || user.member? 
    end
end