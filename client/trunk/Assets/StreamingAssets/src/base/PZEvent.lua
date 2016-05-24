require "base.PZQueen"

PZEvent = class("PZEvent", PZClass)

function PZEvent:ctor()
	
end

function PZEvent:Happen(...)	
	self:DoBeforeHandle(...);

	self:DoHandle(...);

	if not self.eventCarrier then
		self:DoAfterHandle(...);
	end
end

function PZEvent:BeforeHandle()
	
end

function PZEvent:Handle()

end

function PZEvent:AfterHandle()
	
end


function PZEvent:DoBeforeHandle(...)
	self:BeforeHandle();

	if self.eventBeforeCarriers then
		for k,v in pairs(self.eventBeforeCarriers) do
			v(self, ...);
		end
	end
end

function PZEvent:DoHandle(...)
	self:Handle();

	if self.eventCarrier then
		self.eventCarrier(self, ...);
	end
end

function PZEvent:DoAfterHandle(...)
	self:AfterHandle();

	if self.eventAfterCarriers then
		for k,v in pairs(self.eventAfterCarriers) do
			v(self, ...);
		end
	end
end

function PZEvent:AddBeforeHandler(func, obj, priority)
	if not self.eventBeforeCarriers then
		self.eventBeforeCarriers = {};
	end
	if not self.eventBeforeCarriers[priority] then
		self.eventBeforeCarriers[priority] = Event(self.__cname .. "Before" .. tostring(priority), true);
	end
	self.eventBeforeCarriers[priority]:Add(func, obj);
end

function PZEvent:RemoveBeforeHandler(func, obj, priority)
	if not self.eventBeforeCarriers then
		return;
	end
	if not self.eventBeforeCarriers[priority] then
		return;
	end
	self.eventBeforeCarriers[priority]:Remove(func, obj);
end

function PZEvent:AddHandler(func, obj)
	if not self.eventCarrier then
		self.eventCarrier = Event(self.__cname, true);
	end
	self.eventCarrier:Add(func, obj);
end

function PZEvent:RemoveHandler(func, obj)
	if not self.eventCarrier then
		return;
	end
	self.eventCarrier:Remove(func, obj);
end

function PZEvent:AddAfterHandler(func, obj, priority)
	if not self.eventAfterCarriers then
		self.eventAfterCarriers = {};
	end
	if not self.eventAfterCarriers[priority] then
		self.eventAfterCarriers[priority] = Event(self.__cname .. "After" .. tostring(priority), true);
	end
	self.eventAfterCarriers[priority]:Add(func, obj);
end

function PZEvent:RemoveAfterHandler(func, obj, priority)
	if not self.eventAfterCarriers then
		return;
	end
	if not self.eventAfterCarriers[priority] then
		return;
	end
	self.eventAfterCarriers[priority]:Remove(func, obj);
end



PZEventQueen = class("PZEventQueen", PZQueen);

function PZEventQueen:Launch(event)
	local node = nil;
	if event:IsKindOfClass(PZQueenNode) then
		node = event;
	else
		node = PZEventQueenNode.New(event);	
	end
	PZQueen.Launch(self, node);
end


function PZEventQueen:Append(event)
	local node = nil;
	if event:IsKindOfClass(PZQueenNode) then
		node = event;
	else
		node = PZEventQueenNode.New(event);	
	end
	PZQueen.Append(self, node);
end



PZEventQueenNode = class("PZEventQueenNode", PZQueenNode);
function PZEventQueenNode:ctor(event)
	PZQueenNode.ctor(self);
	self.event = event;
	self.event.node = self;
	self.event:DoBeforeHandle();
end

function PZEventQueenNode:Clean()
	PZQueenNode.Clean(self);
	self.event:Clean();
	self.event.node = nil;
end

function PZEventQueenNode:OnStepInto()
	if self.event.timeOut and self.event.timeOutCallback then
		self.timeOutTimer = Timer.New(function()
			self.event.timeOutCallback(self.event);
		end, self.event.timeOut);
		self.timeOutTimer:Start();
	end

	self.event:DoHandle();

	if not self.event.eventCarrier then
		self.queen:StepNext();
	end
end

function PZEventQueenNode:OnStepOut()
	self.event:DoAfterHandle();
	if self.timeOutTimer then
		self.timeOutTimer:Stop();
		self.timeOutTimer = nil;
	end
end


PZFunctionEvent = class("PZFunctionEvent", PZEvent);

function PZFunctionEvent:ctor(func)
	self.func = func;
end

function PZFunctionEvent:Handle()
	if self.func then
		self.func(self);
	end
end


