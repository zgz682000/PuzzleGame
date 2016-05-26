
Block = class("Block", BattleElement);

Block.kRemovedBlockMetaIds = {};

function Block:ctor(elementMetaId)
	BattleElement.ctor(self, elementMetaId);

	if self:GetAutoDecrease() then
		self.remainderRound = self:GetAutoDecrease();
	end
end

function Block:GetCellContainable()
	return ElementMeta[self.metaId].cell_containable;
end

function Block:GetCellGroupCheckable()
	return ElementMeta[self.metaId].cell_group_checkable;
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

function Block:GetPreventLineBomb()
	return ElementMeta[self.metaId].prevent_line_bomb;
end

function Block:GetRenderOrder()
	return ElementMeta[self.metaId].render_order;
end

function Block:GetAutoDecrease()
	return ElementMeta[self.metaId].auto_decrease;
end

function Block:Decrease(group)
	if group and self.currentDecreaseGroup == group then
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


function Block:Grow(grid)
	grid:SetBlock(self);

	local removeCell = nil;
	if grid.cell and not self:GetCellContainable() then
		removeCell = grid.cell;
		grid.cell.isToClean = true;
		grid.cell = nil;
	end

	local e = BlockGrowEvent.New();
	e.block = self;
	e.removeCell = removeCell;
	e:Happen();
end

function Block:Move(grid)
	local preGridKey = HexagonGrid.GetKeyFromPosition(self.position);
	local preGrid = Battle.instance.grids[preGridKey];
	preGrid.block = nil;

	grid:SetBlock(self);

	local e = BlockMoveEvent.New();
	e.block = self;
	e:Happen();
end

function Block:AutoDecrease()
	if not self.remainderRound then
		return false;
	end
	self.remainderRound = self.remainderRound - 1;
	if self.remainderRound == 0 then
		self:Decrease();
		return true;
	end

	return false;
end