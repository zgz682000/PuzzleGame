
LuaBehaviour = class("LuaBehaviour", PZClass);

function LuaBehaviour:ctor(objectName)
    self.objectName = objectName;
end

function LuaBehaviour:GetGameObject()
	return GameObject.Find(self.objectName);
end
function LuaBehaviour:Awake()
	
end

function LuaBehaviour:Start()
	
end

function LuaBehaviour:OnDestroy()

end

