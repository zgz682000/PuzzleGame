GameEventManager = {}

local cacheEvents = {};

local currentGameEvent = nil;

function GameEventManager.Clean()
	if currentGameEvent then
		currentGameEvent = nil;
	end
end

function GameEventManager.PushEventToCache(gameEvent)
	table.insert(cacheEvents, gameEvent);
end

function GameEventManager.PopFrontEventFromCache()
	local ret = cacheEvents[1];
	table.remove(cacheEvents, 1);
	return ret;
end

function GameEventManager.PushEvent(gameEvent)
	if not currentGameEvent then
		currentGameEvent = gameEvent;
		GameEventManager.BeginBeforeHandle(gameEvent);
		callNextFrame(GameEventManager.BeginHandle, gameEvent);
	else
		GameEventManager.AppendAsFirst(currentGameEvent, gameEvent);
	end
end

function GameEventManager.PushFunction(callback)
	local funcEvent = GameFunctionEvent.New(callback);
	GameEventManager.PushEvent(funcEvent);
end

function GameEventManager.AppendAsFirst(o, t)
	if o.nextEvent then
		GameEventManager.AppendAsFirst(o.nextEvent, t);
	else
		o.nextEvent = t;
		GameEventManager.BeginBeforeHandle(t);
	end
end

function GameEventManager.AppendAsLast(o, t)
	o = o:GetLastEvent() or o;

	if o.nextEvent then
		t.nextEvent = o.nextEvent;
		o.nextEvent = t;
	else
		o.nextEvent = t;
	end

	if o.firstEvent then
		t.firstEvent = o.firstEvent;
	else
		t.firstEvent = o;
	end

	t.firstEvent:SetLastEvent(t);

	GameEventManager.BeginBeforeHandle(t);
end

function GameEventManager.EventHandleComplete(gameEvent, stopContinue)
	if gameEvent.class and gameEvent ~= currentGameEvent then
		gameEvent:WillAfterHandle();
		return;
	end

	if not gameEvent.class and gameEvent ~= currentGameEvent.class then
		return;
	end

	currentGameEvent:WillAfterHandle();
	currentGameEvent:StopCompleteTimer();

	local preCurrentEvent = currentGameEvent;
	if preCurrentEvent.nextEvent then
		currentGameEvent = preCurrentEvent.nextEvent;
		callNextFrame(GameEventManager.BeginHandle, currentGameEvent);
	else
		currentGameEvent = nil;
		if preCurrentEvent.firstEvent then
			preCurrentEvent.firstEvent:Clean();
		end
	end
	
	if preCurrentEvent.firstEvent then
		preCurrentEvent:Clean();
	end
end

function GameEventManager.BeginBeforeHandle(c)
	if c.isBeforeHandleInvoked then
		return;
	end
	c:DoBeforeHandle();
end

function GameEventManager.BeginHandle(c)
	currentGameEvent = c;
	currentGameEvent:StartCompleteTimer();
	currentGameEvent:DoHappen();
end

function GameEventManager.GetCurrentEvent()
	return currentGameEvent;
end

GameEvent = class("GameEvent", PZClass)

function GameEvent:ctor()
	self.lastEvent = nil;
	self.firstEvent = nil;
	self.nextEvent = nil;
end

function GameEvent:Clean()
	self.firstEvent = nil;
	self.nextEvent = nil;
	self.lastEvent = nil;
end

function GameEvent:StartCompleteTimer()
	if not self.completeTimer then
		self.completeTimer = Timer.New(function()
			PZAssert(false, "event error " .. self.__cname);
			GameEventManager.EventHandleComplete(self);
		end, 10);
		self.completeTimer:Start();
	end
end

function GameEvent:StopCompleteTimer()
	if self.completeTimer then
		self.completeTimer:Stop();
		self.completeTimer = nil;
	end
end

function GameEvent:GetLastEvent()
	if self.firstEvent then
		return self.firstEvent:GetLastEvent();
	elseif self.lastEvent then
		return self.lastEvent;
	else
		return self;
	end
end

function GameEvent:SetLastEvent(lastEvent)
	if self.firstEvent then
		self.firstEvent:SetLastEvent(lastEvent);
	else
		self.lastEvent = lastEvent;
	end
end

function GameEvent:OnHandle()
	
end

function GameEvent:AfterHandle()

end

function GameEvent:BeforeHandle()
	
end

function GameEvent:DoBeforeHandle(...)
	if self.eventImmediatelyCarriers then
		for k,v in pairs(self.eventImmediatelyCarriers) do
			v(self, ...);
		end
	end


	self:BeforeHandle();
	self.isBeforeHandleInvoked = true;

	if self.eventBeforeCarriers then
		for k,v in pairs(self.eventBeforeCarriers) do
			v(self, ...);
		end
	end
end

function GameEvent:Happen( ... )
	self:DoBeforeHandle(...);
	self:DoHappen();
	self:WillAfterHandle(...)
end

function GameEvent:DoHappen(...)
	self:OnHandle();

	if not self.eventCarrier then
		if self == currentGameEvent then
			GameEventManager.EventHandleComplete(self);
		end
		return;
	end
	self.eventCarrier(self, ...);
end

function GameEvent:WillAfterHandle(...)
	if self.eventAfterCarriers then
		for k,v in pairs(self.eventAfterCarriers) do
			v(self,...);
		end
	end
	self:AfterHandle();
end

function GameEvent:AddHandler(func, obj)
	if not self.eventCarrier then
		self.eventCarrier = Event(self.__cname, true);
	end
	self.eventCarrier:Add(func, obj);
end

function GameEvent:RemoveHandler(func, obj)
	if not self.eventCarrier then
		return;
	end
	self.eventCarrier:Remove(func, obj);
end

function GameEvent:AddImmediatelyHandler(func, obj, priority)
	if not self.eventImmediatelyCarriers then
		self.eventImmediatelyCarriers = {};
	end
	if not self.eventImmediatelyCarriers[priority] then
		self.eventImmediatelyCarriers[priority] = Event(self.__cname .. "Immediately" .. tostring(priority), true);
	end
	self.eventImmediatelyCarriers[priority]:Add(func, obj);
end

function GameEvent:RemoveImmediatelyHandler(func, obj, priority)
	if not self.eventImmediatelyCarriers then
		return;
	end
	if not self.eventImmediatelyCarriers[priority] then
		return;
	end
	self.eventImmediatelyCarriers[priority]:Remove(func, obj);
end

function GameEvent:AddBeforeHandler(func, obj, priority)
	if not self.eventBeforeCarriers then
		self.eventBeforeCarriers = {};
	end
	if not self.eventBeforeCarriers[priority] then
		self.eventBeforeCarriers[priority] = Event(self.__cname .. "Before" .. tostring(priority), true);
	end
	self.eventBeforeCarriers[priority]:Add(func, obj);
end



function GameEvent:RemoveBeforeHandler(func, obj, priority)
	if not self.eventBeforeCarriers then
		return;
	end
	if not self.eventBeforeCarriers[priority] then
		return;
	end
	self.eventBeforeCarriers[priority]:Remove(func, obj);
end

function GameEvent:AddAfterHandler(func, obj, priority)
	if not self.eventAfterCarriers then
		self.eventAfterCarriers = {};
	end
	if not self.eventAfterCarriers[priority] then
		self.eventAfterCarriers[priority] = Event(self.__cname .. "After" .. tostring(priority), true);
	end
	self.eventAfterCarriers[priority]:Add(func, obj);
end

function GameEvent:RemoveAfterHandler(func, obj, priority)
	if not self.eventAfterCarriers then
		return;
	end
	if not self.eventAfterCarriers[priority] then
		return;
	end
	self.eventAfterCarriers[priority]:Remove(func, obj);
end


GameFunctionEvent = class("GameFunctionEvent", GameEvent);

function GameFunctionEvent:ctor(func)
	self.func = func;
end

function GameFunctionEvent:OnHandle()
	if self.func then
		self.func(self);
	end
	GameEventManager.EventHandleComplete(self);
end


