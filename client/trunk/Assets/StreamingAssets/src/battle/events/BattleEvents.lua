require "base.PZEvent"


BattleEvent = class("BattleEvent", PZEvent);
function BattleEvent:ctor()
	self.timeOut = 15;
	self.timeOutCallback = self.OnTimeOut;
end

function BattleEvent:OnTimeOut()
	PZAssert(false, "event error " .. self.__cname);
end


EmptyBattleEvent = class("EmptyBattleEvent", BattleEvent);


CellExchangedEvent = class("CellExchangedEvent", BattleEvent);

function CellExchangedEvent:ctor()
	BattleEvent.ctor(self);
	self.cell = nil;
	self.fromGrid = nil;
	self.toGrid = nil;
end


CellExchangeCanceledEvent = class("CellExchangeCanceledEvent", BattleEvent)

function CellExchangeCanceledEvent:ctor()
	BattleEvent.ctor(self);
	self.cell = nil;
	self.fromGrid = nil;
	self.toGrid = nil;
end


CellGroupRemovedEvent = class("CellGroupRemovedEvent", BattleEvent);

function CellGroupRemovedEvent:ctor()
	BattleEvent.ctor(self);
	self.group = nil;
end


CellRemovedEvent = class("CellRemovedEvent", BattleEvent);

function CellRemovedEvent:ctor()
	BattleEvent.ctor(self);
	self.grid = nil;
	self.cell = nil;
end

function CellRemovedEvent:BeforeHandle()
	if self.cell.elementId == 151 then
		print("bomb cell remove");
	end
end


CellDropEvent = class("CellDropEvent", BattleEvent);

function CellDropEvent:ctor()
	BattleEvent.ctor(self);
	self.cell = nil;
	self.fromGrid = nil;
	self.toGrid = nil;
end

function CellDropEvent:AfterHandle()
	self.cell.dropDistance = self.cell.dropDistance + 1;
end


CellGeneratedEvent = class("CellGeneratedEvent", BattleEvent);

function CellGeneratedEvent:ctor()
	BattleEvent.ctor(self);
	self.grid = nil;
	self.cell = nil;
end

function CellGeneratedEvent:BeforeHandle()
	 
end

function CellGeneratedEvent:AfterHandle()
	self.cell.eventQueen:Resume();
end


CellAlertEvent = class("CellAlertEvent", BattleEvent);
function CellAlertEvent:ctor()
	BattleEvent.ctor(self);
	self.cell = nil;
end


CellRerangeEvent = class("CellRerangeEvent", BattleEvent);
function CellRerangeEvent:ctor()
	BattleEvent.ctor(self);
	self.cell = nil;
end



BombCellGenerateEvent = class("BombCellGenerateEvent", BattleEvent);
function BombCellGenerateEvent:ctor()
	BattleEvent.ctor(self);
	self.bombCell = nil;
end
function BombCellGenerateEvent:AfterHandle()
	self.bombCell.eventQueen:Resume();
end


CellConventEvent = class("CellConventEvent", BattleEvent);
function CellConventEvent:ctor()
	BattleEvent.ctor(self);
	self.preCell = nil;
	self.conventCell = nil;
end

function CellConventEvent:AfterHandle()
	self.conventCell.eventQueen:Resume();
end


BlockDecreaseEvent = class("BlockDecreaseEvent", BattleEvent);

function BlockDecreaseEvent:ctor()
	BattleEvent.ctor(self);
	self.block = nil;
	self.remove = false;
end


BlockGrowEvent = class("BlockGrowEvent", BattleEvent);
function BlockGrowEvent:ctor()
	BattleEvent.ctor(self);
	self.block = nil;
	self.removeCell = nil;
end

