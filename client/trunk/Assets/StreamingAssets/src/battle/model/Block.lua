
Block = class("Block", BattleElement);

Block.kRemovedBlockMetaIds = {};

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

function Block:GetDecreaseToMetaId()
	return ElementMeta[self.metaId].decrease_to;
end

function Block:Decrease(group)
	if self.currentDecreaseGroup == group then
		return;
	end

	local decreaseToMetaId = self:GetDecreaseToMetaId();

	self.currentDecreaseGroup = group;

	local e = BlockDecreaseEvent.New();
	if decreaseToMetaId then
		self.metaId = decreaseToMetaId;
	else
		e.remove = true;
		local grid = self:GetGrid();
		PZAssert(grid.block == self, "block decrease error")
		grid.block = nil;

		if ElementMeta[self.metaId].round_step then
			Block.kRemovedBlockMetaIds[self.metaId] = true;
		end
	end
	e.block = self;
	e:Happen();
end


function Block:GetGrid()
	local key = HexagonGrid.GetKeyFromPosition(self.position);
	return Battle.instance.grids[key];
end


function Block:Grow()
	
end



