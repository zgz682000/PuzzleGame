
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

function HexagonGrid:RemoveCell(bombGroup)
	if not self.cell then
		return;
	end

	local cell = self.cell;
	self.cell.isToClean = true;
	self.cell = nil;

	cell:OnRemoved(bombGroup);

	local e = CellRemovedEvent.New();
	e.grid = self;
	e.cell = cell;
	cell.eventQueen:Append(e);
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
	PZAssert(not self.cell, "cell is no nil");

	local topGrid = self:GetGridByDirection(HexagonGrid.Direction.Top);
	if topGrid then
		if  topGrid.cell then
			local preCell = topGrid.cell;
			local preGrid = topGrid;
			self:SetCell(preCell);
			preGrid:SetCell(nil);

			local e = CellDropEvent.New();
			e.cell = preCell;
			e.fromGrid = preGrid;
			e.toGrid = self;
			e.cell.eventQueen:Append(e);

			-- PZPrint("CellDropEvent BeforeHandle cell_" .. e.cell.elementId .. " from " .. tostring(e.fromGrid:GetKey()) .. " to " .. tostring(e.toGrid:GetKey()) .. " queen count " .. e.node.queen:Count());

			-- preGrid:Reset();

			return preCell;
		else
			return topGrid:Reset();
		end
	end

	local upLeftGrid = self:GetGridByDirection(HexagonGrid.Direction.UpLeft);
	if upLeftGrid then
		if  upLeftGrid.cell then
			local preCell = upLeftGrid.cell;
			local preGrid = upLeftGrid;
			self:SetCell(preCell);
			preGrid:SetCell(nil);

			local e = CellDropEvent.New();
			e.cell = preCell;
			e.fromGrid = preGrid;
			e.toGrid = self;
			e.cell.eventQueen:Append(e);

			-- PZPrint("CellDropEvent BeforeHandle cell_" .. e.cell.elementId .. " from " .. tostring(e.fromGrid:GetKey()) .. " to " .. tostring(e.toGrid:GetKey()) .. " queen count " .. e.node.queen:Count());

			-- preGrid:Reset();

			return preCell;
		else
			return upLeftGrid:Reset();
		end
	end


	local upRightGrid = self:GetGridByDirection(HexagonGrid.Direction.UpRight);
	if upRightGrid then
		if  upRightGrid.cell then
			local preCell = upRightGrid.cell;
			local preGrid = upRightGrid;
			self:SetCell(preCell);
			preGrid:SetCell(nil);

			local e = CellDropEvent.New();
			e.cell = preCell;
			e.fromGrid = preGrid;
			e.toGrid = self;
			e.cell.eventQueen:Append(e);

			-- PZPrint("CellDropEvent BeforeHandle cell_" .. e.cell.elementId .. " from " .. tostring(e.fromGrid:GetKey()) .. " to " .. tostring(e.toGrid:GetKey()) .. " queen count " .. e.node.queen:Count());

			-- preGrid:Reset();

			return preCell;
		else
			return upRightGrid:Reset();
		end
	end
end


HexagonGridGenerator = class("HexagonGridGenerator", HexagonGrid);

function HexagonGridGenerator:Reset()
	PZAssert(not self.cell, "cell is no nil");

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


