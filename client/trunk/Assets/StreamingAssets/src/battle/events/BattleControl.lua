
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
		ReplayManager.RecordControl(self);
	end
end

function BattleControl:Encode(params)

end

function BattleControl:Decode(params)
	
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

function BattleControlExchange:Encode(params)
	BattleControl.Encode(self, params);
	params.grid = self.grid:GetKey();
	params.direction = self.direction.index;
end

function BattleControlExchange:Decode(params)
	BattleControl.Decode(self, params);
	self.grid = Battle.instance.grids[params.grid];
	self.direction = HexagonGrid.Directions[params.direction];
end