
Block = class("Block", BattleElement);


function Block:ctor(elementMetaId)
	BattleElement.ctor(self, elementMetaId);
end

function Block:GetCellContainable()
	return ElementMeta[self.metaId].cell_contain;
end

function Block:GetCellMoveable()
	return ElementMeta[self.metaId].cell_moveable;
end

function Block:GetCellRemoveable()
	return ElementMeta[self.metaId].cell_removeable;
end

function Block:GetSelfRemoveDecreaseable()
	return ElementMeta[self.metaId].self_remove_decrease;
end

function Block:GetSelfBombDecreaseable()
	return ElementMeta[self.metaId].self_bomb_decrease;
end

function Block:GetSideRemoveDescreaseable()
	return ElementMeta[self.metaId].side_remove_decrease;
end

function Block:GetSideBombDecreaseable()
	return ElementMeta[self.metaId].side_bomb_decrease;
end

function Block:GetRoundTriggerFunctionName()
	return ElementMeta[self.metaId].round_trigger;
end

function Block:RoundTrigger(...)
	local funcName = self:GetRoundTriggerFunctionName();
	if self[funcName] then
		self[funcName](...);
	end
end

function Block:GetDecreaseToMetaId()
	return ElementMeta[self.metaId].decrease_to;
end

function Block:Decrease(eventQueen)
	local decreaseToMetaId = self:GetDecreaseToMetaId();

	local e = BlockDecreaseEvent.New();
	if decreaseToMetaId then
		self.elementMetaId = decreaseToMetaId;
	else
		e.remove = true;
		local grid = self:GetGrid();
		PZAssert(grid.block == self, "block decrease error")
		grid.block = nil;
	end
	e.block = self;
	eventQueen:Append(e);
end


function Block:GetGrid()
	local key = HexagonGrid.GetKeyFromPosition(self.position);
	return Battle.instance.grids[key];
end