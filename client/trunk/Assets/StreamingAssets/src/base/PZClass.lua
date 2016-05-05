
PZClass = class("PZClass");

function PZClass:IsKindOfClass(class)
    local selfClass = self.class;
    if not selfClass then
        return false;
    elseif selfClass == class then
        return true;
    else
        return selfClass:IsSubOfClass(class)
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
        return class.super:IsSubOfClass(superClass);
    end
end


function PZClass:ctor()
    
end

function PZClass:Clean()

end

local function serialize(o, retStrTable, level, pretty)
    if type(o) == "number" then
        table.insert(retStrTable,o)
    elseif type(o) == "string" then
        table.insert(retStrTable,string.format("%q", o))
    elseif type(o) == "table" then
        table.insert(retStrTable,"{")
        
        if pretty then
            table.insert(retStrTable,"\n");
        end
        
        local i = 1;

        for key, var in pairs(o) do
            if not string.find(key, "__") and type(var) ~= "function" then
                if pretty then
                    for i=1,level do
                        table.insert(retStrTable,"\t");
                    end
                end
                if type(key) == "number" then
                    if key == i then
                        i = i + 1;
                    else
                        table.insert(retStrTable,"[")
                        table.insert(retStrTable,key)
                        table.insert(retStrTable,"]")
                        table.insert(retStrTable," = ")
                    end
                elseif type(key) == "string" then
                    table.insert(retStrTable,key)
                    table.insert(retStrTable," = ")
                end
                
                serialize(var,retStrTable, level + 1, pretty);
                table.insert(retStrTable,", ")
                if pretty then
                    table.insert(retStrTable,"\n");
                end
            end
        end
        if pretty then
            if retStrTable[#retStrTable - 1] == ", " then
                table.remove(retStrTable, #retStrTable - 1);
            end
        else
            if retStrTable[#retStrTable] == ", " then
                table.remove(retStrTable, #retStrTable);
            end
        end
        if pretty then
            for i=1,level - 1 do
                table.insert(retStrTable,"\t");
            end
        end
        table.insert(retStrTable,"}")
    else

    end
end

function PZClass:Serialize(pretty)
    local retStrTable = {};
    serialize(self, retStrTable, 1, pretty);
    return table.concat(retStrTable);
end
