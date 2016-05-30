
Gate = class("Gate", BattleElement);


GateEnter = class("GateEnter", Gate);

function GateEnter:ctor(elementMetaId)
	Gate.ctor(self, elementMetaId);

	self.pair = nil;
end

function GateEnter:GetPairGrid()
	return Battle.instance.grids[self.pair];
end


GateExit = class("GateExit", Gate);


function GateExit:ctor(elementMetaId)
	Gate.ctor(self, elementMetaId);

	self.pair = nil;
end

function GateExit:GetPairGrid()
	return Battle.instance.grids[self.pair];
end