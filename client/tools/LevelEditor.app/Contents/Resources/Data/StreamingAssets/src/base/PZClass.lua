
PZClass = class("PZClass");

function PZClass:IsKindOfClass(class)
    local selfClass = self.class;
    if not selfClass then
        return false;
    elseif selfClass == class then
        return true;
    else
        return selfClass:isSubOfClass(class)
    end
end

function PZClass:IsSubOfClass(superClass)
    if not superClass then
        return true;
    end

    local class = nil;

    if self.__cname then
        class = self;
    else
        return false;
    end

    if not class.super then
    	return false;
    elseif class.super == superClass then
    	return true;
    else
        return class.super:isSubOfClass(superClass);
    end
end


function PZClass:ctor()
    
end

function PZClass:Clean()

end
