require "battle.model.HexagonGridGroup"


MoveCell = class("MoveCell", BattleElement);


MoveCell.Color = {
	red = {
		index = 1,
	},
	orange = {
		index = 2,
	},
	green = {
		index = 3,
	},
	blue = {
		index = 4,
	},
	purple = {
		index = 5,
	}
}

MoveCell.Colors = {MoveCell.Color.red , MoveCell.Color.orange, MoveCell.Color.green, MoveCell.Color.blue, MoveCell.Color.purple}


function MoveCell:ctor(cellMetaId)
	BattleElement.ctor(self, cellMetaId);
	self.isToClean = false;
	self.eventQueen = PZEventQueen.New();
	self.dropDistance = 0;
	self.eventQueen.OnFinished = function (q)
		Battle.instance:OnCellEventQueenFinish(self);
		if self.isToClean then
			self:Clean();
		end
	end
	self.eventQueen.OnLaunch = function (q)
		Battle.instance:OnCellEventQueenLaunch(self);
	end
end

function MoveCell:Clean()
	self.eventQueen:Clean();
end


function MoveCell:GetColor()
	return ElementMeta[self.metaId].color;
end

function MoveCell:GetGrid()
	local key = HexagonGrid.GetKeyFromPosition(self.position);
	return Battle.instance.grids[key];
end


function MoveCell:CheckOutGroups(groups)
	local selfGrid = self:GetGrid();
	if selfGrid.block and not selfGrid.block:GetCellGroupCheckable() then
		return;
	end
	for k,v in pairs(HexagonGrid.Direction) do
		local otherGrid = selfGrid:GetGridByDirection(v);
		if otherGrid and otherGrid.cell and (not otherGrid.block or otherGrid.block:GetCellGroupCheckable()) then
			local otherCell = otherGrid.cell;
			if otherCell and otherCell:GetColor() == self:GetColor() then
				local groupLine = MoveCellGroupLine.New(self, otherCell, v);
				local f = false;
				for ii,vv in ipairs(groups) do
					local newGroup = vv:Merge(groupLine); 
					if newGroup then
						groups[ii] = newGroup;
						f = true;
					end
				end
				if not f then
					table.insert(groups, groupLine);
				end
			end
		end
	end
end


function MoveCell:Reorder(grid)
	grid:SetCell(self);

	local e = CellExchangedEvent.New();
	e.fromGrid = self:GetGrid();
	e.toGrid = grid;
	e.cell = self;
	e.cell.eventQueen:Append(e);
end


function MoveCell:OnRemoved(group)
	local score = 0;
	if group:IsKindOfClass(MoveCellGroup) then
		local n = #group:GetCells();
		score = Constant.baseRemoveScore(n);
	elseif group:IsKindOfClass(HexagonGridGroupColor) then
		score = Constant.sameColorRemoveScore;
	elseif group:IsKindOfClass(HexagonGridGroupAll) then
		score = Constant.allRemoveScore;
	elseif group:IsKindOfClass(HexagonGridGroup) then
		local m = group:GetScoreCellsCount();
		score = Constant.bombRemoveScore(m);
	end
	Battle.instance:CellScore(score, self);
end

function MoveCell:GetGridGroupWithCell(cell)
	return nil;
end

MoveCellNormal = class("MoveCellNormal", MoveCell);

function MoveCellNormal:GetGridGroupWithCell(cell)
	if cell:IsKindOfClass(MoveCellBomb) then
		return cell:GetGridGroupWithCell(self);
	else
		return nil;
	end
end

MoveCellBomb = class("MoveCellBomb", MoveCell);

function MoveCellBomb:InitAtGrid(bombGrid)
	self.eventQueen:Pause();

	bombGrid:SetCell(self);

	local e = BombCellGenerateEvent.New();
	e.bombCell = self;
	bombGrid.preCell.eventQueen:Append(e);
end

function MoveCellBomb:GetGridGroupWithCell(cell)
	return nil;
end

MoveCellLineBomb = class("MoveCellLineBomb", MoveCellBomb);

function MoveCellLineBomb:ctor(cellMetaId)
	MoveCellBomb.ctor(self, cellMetaId);
	self.direction = nil;
end

function MoveCellLineBomb.ConvertDirectionToMetaIdFactor(d)
	if d == HexagonGrid.Direction.Top or d == HexagonGrid.Direction.Bottom then
		return 1
	elseif d == HexagonGrid.Direction.UpLeft or d == HexagonGrid.Direction.DownRight then
		return 2;
	elseif d == HexagonGrid.Direction.UpRight or d == HexagonGrid.Direction.DownLeft then
		return 3;
	end
end

function MoveCellLineBomb:OnRemoved(group)
	local g = HexagonGridGroupLines.New();
	g:AddLocation(self:GetGrid(), self.direction);
	g:RemoveGridsCell();
end

function MoveCellLineBomb:GetGridGroupWithCell(cell)
	local retGridGroup = nil;
	if cell:IsKindOfClass(MoveCellLineBomb) then
		retGridGroup = HexagonGridGroupLines.New();
		retGridGroup:AddLocation(self:GetGrid(), self.direction);
		retGridGroup:AddLocation(cell:GetGrid(),cell.direction);
	elseif cell:IsKindOfClass(MoveCellAreaBomb) then
		retGridGroup = HexagonGridGroupLines.New();

		local centerGrid1 = self:GetGrid();
		retGridGroup:AddLocation(self:GetGrid(), self.direction);

		local centerGrid2Direction = HexagonGrid.Directions[self.direction.index % 6 + 1];
		local centerGrid2 = centerGrid1:GetGridByDirection(centerGrid2Direction);
		if centerGrid2 then
			retGridGroup:AddLocation(centerGrid2 ,self.direction);
		end

		local centerGrid3Direction = HexagonGrid.Directions[(self.direction.index - 2) % 6 + 1];
		local centerGrid3 = centerGrid1:GetGridByDirection(centerGrid3Direction);
		if centerGrid3 then
			retGridGroup:AddLocation(centerGrid3 ,self.direction);
		end
	elseif cell:IsKindOfClass(MoveCellColorBomb) then
		return cell:GetGridGroupWithCell(self);
	end

	return retGridGroup;
end

MoveCellAreaBomb = class("MoveCellAreaBomb", MoveCellBomb);

function MoveCellAreaBomb:OnRemoved(group)
	local g = HexagonGridGroupArea.New();
	g.centerGrid = self:GetGrid();
	g.radius = 1;
	g:RemoveGridsCell();
end


function MoveCellAreaBomb:GetGridGroupWithCell(cell)
	local retGridGroup = nil;
	if cell:IsKindOfClass(MoveCellLineBomb) then
		return cell:GetGridGroupWithCell(self);
	elseif cell:IsKindOfClass(MoveCellAreaBomb) then
		retGridGroup = HexagonGridGroupArea.New();
		retGridGroup.centerGrid = self:GetGrid();
		retGridGroup.radius = 2;
	elseif cell:IsKindOfClass(MoveCellColorBomb) then
		return cell:GetGridGroupWithCell(self);	
	end

	return retGridGroup;
end

MoveCellColorBomb = class("MoveCellColorBomb", MoveCellBomb);

function MoveCellColorBomb:OnRemoved(group)
	if not group or (group:IsKindOfClass(HexagonGridGroup) and (not group.centerGrid or group.centerGrid ~= self:GetGrid())) then
		local randomCellId = Battle.instance:GetRandomElementMetaId();
		local randomColor = ElementMeta[randomCellId].color;
		local g = HexagonGridGroupColor.New();
		g.centerGrid = self:GetGrid();
		g.color = randomColor;
		g:RemoveGridsCell();
	end
end

function MoveCellColorBomb:GetGridGroupWithCell(cell)
	local retGridGroup = nil;
	if cell:IsKindOfClass(MoveCellLineBomb) or cell:IsKindOfClass(MoveCellAreaBomb) then
		retGridGroup = HexagonGridGroupColorConvert.New();
		retGridGroup.color = cell:GetColor();
		retGridGroup.centerGrid = self:GetGrid();
		retGridGroup.otherBomb = cell;
	elseif cell:IsKindOfClass(MoveCellColorBomb) then
		retGridGroup = HexagonGridGroupAll.New();
	elseif cell:IsKindOfClass(MoveCellNormal) then
		retGridGroup = HexagonGridGroupColor.New();
		retGridGroup.centerGrid = self:GetGrid();
		retGridGroup.color = cell:GetColor();
	end
	return retGridGroup;
end


