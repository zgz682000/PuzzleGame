
require "base.PZEvent"



BattleControl = class("BattleControl", PZEvent);

BattleControl.enabled = false;

BattleControl.currentControl = nil;

function BattleControl:ctor()
	
end

function BattleControl:BeforeHandle()
	
end


function BattleControl:Happen(...)
	if BattleControl.enabled then
		BattleControl.currentControl = self;
		PZEvent.Happen(self, ...);
	end
end

BattleControlExchange = class("BattleControlExchange", BattleControl)

function BattleControlExchange:ctor()
	self.grid = nil;
	self.direction = nil;
end

function BattleControlExchange:BeforeHandle()
	BattleControl.BeforeHandle(self);

	Battle.instance:ExchangeCellToDirection(self.grid, self.direction);
end


