
HexagonGrid = class("HexagonGrid", BattleElement);

HexagonGrid.Direction = {
	Top = { --上边
		index = 1,
		positionOffset = {
			x = 0,
			y = 0.866
		},
	}, 
	UpRight = {
		index = 2,
		positionOffset = {
			x = 0.75,
			y = 0.433,
		}
	},
	DownRight = {
		index = 3,
		positionOffset = {
			x = 0.75,
			y = -0.433,
		}
	},
	Bottom = {
		index = 4,
		positionOffset = {
			x = 0,
			y = -0.866,
		}
	},
	DownLeft = {
		index = 5,
		positionOffset = {
			x = -0.75,
			y = -0.433,
		}
	},
	UpLeft = {
		index = 6,
		positionOffset = {
			x = -0.75,
			y = 0.433,
		}
	}
}

HexagonGrid.Directions = {HexagonGrid.Direction.Top, HexagonGrid.Direction.UpRight, HexagonGrid.Direction.DownRight, HexagonGrid.Direction.Bottom, HexagonGrid.Direction.DownLeft, HexagonGrid.Direction.UpLeft}


function HexagonGrid:ctor(gridMetaId)
	BattleElement.ctor(self, gridMetaId);
	self.cell = nil;
	self.block = nil;
	self.gate = nil;
end

function HexagonGrid:Clean()
	if self.cell then
		self.cell:Clean();
	end	
end

function HexagonGrid:GetKey()
	return HexagonGrid.GetKeyFromPosition(self.position);
end

function HexagonGrid:GetPositionByDirection(direction)
	local x = self.position.x + direction.positionOffset.x;
	local y = self.position.y + direction.positionOffset.y;
	return {x = x, y = y};
end

function HexagonGrid.GetKeyFromPosition(position)
	local ix = math.modf(position.x * 1000 + 0.5);
	local iy = math.modf(position.y * 1000 + 0.5);
	local ret = math.modf(ix * 10000 + iy);
	return ret;
end

function HexagonGrid.GetPositionFromKey(key)
	local x = math.modf(key / 10000) / 1000;
	local y = key % 10000 / 1000;
	return {x = x, y = y};
end

function HexagonGrid:SetCell(cell)
	if not self.preCell and not self.cell then
		self.preCell = cell;
	end

	if self.cell then
		self.preCell = self.cell;
	end
	self.cell = cell;
	if self.cell then
		self.cell:SetPosition(self.position);
	end
end


function HexagonGrid:SetBlock(block)
	self.block = block;
	if self.block then
		self.block:SetPosition(self.position);
	end
end

function HexagonGrid:SetGate(gate)
	self.gate = gate;
	if self.gate then
		self.gate:SetPosition(self.position);
	end
end

function HexagonGrid:RemoveCell(group)

	local shouldRemoveCell = not self.block or self.block:GetCellRemoveable();

	if group then
		local removeGroup = nil;
		local bombGroup = nil;
		if group:IsKindOfClass(MoveCellGroup) then
			removeGroup = group;
		elseif group:IsKindOfClass(HexagonGridGroup) then
			bombGroup = group;
		end

		if removeGroup and self.block and self.block:GetSelfRemoveDecreaseable() then
			self.block:Decrease(removeGroup);
		end

		if bombGroup and self.block and self.block:GetSelfBombDecreaseable() then
			self.block:Decrease(bombGroup);
		end


		if shouldRemoveCell then
			for i,d in ipairs(HexagonGrid.Directions) do
				local otherGrid = self:GetGridByDirection(d);
				if otherGrid and otherGrid.block then
					if removeGroup and otherGrid.block:GetSideRemoveDescreaseable() then
						otherGrid.block:Decrease(removeGroup);
					end

					if bombGroup and otherGrid.block:GetSideBombDecreaseable() then 
						otherGrid.block:Decrease(bombGroup);
					end
				end
			end
		end
	end


	if self.cell and shouldRemoveCell then

		local cell = self.cell;
		self.cell.isToClean = true;
		self.cell = nil;

		cell:OnRemoved(group);

		local e = CellRemovedEvent.New();
		e.grid = self;
		e.cell = cell;
		cell.eventQueen:Append(e);

	end
end

function HexagonGrid:ConvertCell(bomb)
	if not self.cell then
		return;
	end
	
	bomb.eventQueen:Pause();

	local cell = self.cell;
	self.cell.isToClean = true;
	self:SetCell(bomb);
	
	local e = CellConventEvent.New();
	e.preCell = cell;
	e.conventCell = bomb;
	cell.eventQueen:Append(e);
end

function HexagonGrid:Reset()

end

function HexagonGrid:GetDirectionOfGrid(grid)
	for k,v in pairs(HexagonGrid.Direction) do
		local otherGrid = self:GetGridByDirection(v);
		if otherGrid and otherGrid.position.x == grid.position.x and otherGrid.position.y == grid.position.y then
			return v;
		end
	end
end

function HexagonGrid:GetGridByDirection(direction)
	local otherPosition = self:GetPositionByDirection(direction);
	local otherKey = HexagonGrid.GetKeyFromPosition(otherPosition);
	local otherGrid = Battle.instance.grids[otherKey];
	return otherGrid;
end

HexagonGridNormal = class("HexagonGridNormal", HexagonGrid);


function HexagonGridNormal:Reset()
	PZAssert(not self.cell, "cell is not nil " .. self:GetKey());
	PZAssert(not self.block or self.block:GetCellContainable(), "block not containable");

	if self.gate and self.gate:IsKindOfClass(GateExit) then
		local pairGrid = self.gate:GetPairGrid();
		if pairGrid and (not pairGrid.block or pairGrid.block:GetCellContainable()) then
			if pairGrid.cell then
				if not pairGrid.block or pairGrid.block:GetCellMoveable() then
					local preCell = pairGrid.cell;
					local preGrid = pairGrid;
					self:SetCell(preCell);
					preGrid:SetCell(nil);

					local e = CellDropEvent.New();
					e.cell = preCell;
					e.fromGrid = preGrid;
					e.toGrid = self;
					e.dropFromGateWay = true; 
					e.cell.eventQueen:Append(e);

					return preCell;
				end
			else
				local preCell = pairGrid:Reset();
				if preCell then
					return preCell;
				end
			end
		end
	end


	local topGrid = self:GetGridByDirection(HexagonGrid.Direction.Top);
	if topGrid and (not topGrid.gate or not topGrid.gate:IsKindOfClass(GateEnter)) and (not topGrid.block or topGrid.block:GetCellContainable()) then
		if topGrid.cell then
			if not topGrid.block or topGrid.block:GetCellMoveable() then
				local preCell = topGrid.cell;
				local preGrid = topGrid;
				self:SetCell(preCell);
				preGrid:SetCell(nil);

				local e = CellDropEvent.New();
				e.cell = preCell;
				e.fromGrid = preGrid;
				e.toGrid = self;
				e.cell.eventQueen:Append(e);

				return preCell;
			end
		else
			local preCell = topGrid:Reset();
			if preCell then
				return preCell;
			end
		end
	end

	local upLeftGrid = self:GetGridByDirection(HexagonGrid.Direction.UpLeft);
	if upLeftGrid and (not upLeftGrid.gate or not upLeftGrid.gate:IsKindOfClass(GateEnter)) and (not upLeftGrid.block or upLeftGrid.block:GetCellContainable()) then
		if  upLeftGrid.cell then
			if not upLeftGrid.block or upLeftGrid.block:GetCellMoveable() then
				local preCell = upLeftGrid.cell;
				local preGrid = upLeftGrid;
				self:SetCell(preCell);
				preGrid:SetCell(nil);

				local e = CellDropEvent.New();
				e.cell = preCell;
				e.fromGrid = preGrid;
				e.toGrid = self;
				e.cell.eventQueen:Append(e);

				return preCell;
			end
		else
			local preCell = upLeftGrid:Reset();
			if preCell then
				return preCell;
			end
		end
	end


	local upRightGrid = self:GetGridByDirection(HexagonGrid.Direction.UpRight);
	if upRightGrid and (not upRightGrid.gate or not upRightGrid.gate:IsKindOfClass(GateEnter)) and (not upRightGrid.block or upRightGrid.block:GetCellContainable()) then
		if  upRightGrid.cell then
			if not upRightGrid.block or upRightGrid.block:GetCellMoveable() then
				local preCell = upRightGrid.cell;
				local preGrid = upRightGrid;
				self:SetCell(preCell);
				preGrid:SetCell(nil);

				local e = CellDropEvent.New();
				e.cell = preCell;
				e.fromGrid = preGrid;
				e.toGrid = self;
				e.cell.eventQueen:Append(e);

				return preCell;
			end
		else
			local preCell = upRightGrid:Reset();
			if preCell then
				return preCell;
			end
		end
	end
end


HexagonGridGenerator = class("HexagonGridGenerator", HexagonGrid);

function HexagonGridGenerator:Reset()
	PZAssert(not self.cell, "cell is no nil");
	PZAssert(not self.block or self.block:GetCellContainable(), "block not containable");

	self:GenerateNewCell();

	return self.cell;
end

function HexagonGridGenerator:GenerateNewCell()
	local randomElementMetaId = Battle.instance:GetRandomElementMetaId();
	local cell = BattleElement.CreateElementByMetaId(randomElementMetaId);
	cell.eventQueen:Pause();
	self:SetCell(cell);

	local e = CellGeneratedEvent.New();
	e.cell = cell;
	e.grid = self;
 	
	self.preCell.eventQueen:Append(e);  --2016年6月31日， 如果注销掉Pause一行，会出现连续多次出发Battle:OnCellEventQueenFinish的情况，导致流程向下连走多步，然后停止
end


