require "battle.model.MoveCell"

MoveCellGroup = class("MoveCellGroup", PZClass);

function MoveCellGroup:ctor()
	self.color = nil;
end


function MoveCellGroup:Merge(group)

end

function MoveCellGroup:GetCells()
	return nil;
end

function MoveCellGroup:GetPublicCells(group)
	local ret = {};
	for _,v1 in ipairs(self:GetCells()) do
		for _,v2 in ipairs(group:GetCells()) do
			if v1 == v2 then
				table.insert(ret, v1);
			end
		end
	end
	return ret;
end

function MoveCellGroup:GetCellsAvailable()
	for i,v in ipairs(self:GetCells()) do
		local grid = v:GetGrid();
		if grid.cell ~= v then
			return false;
		end
	end
	return true;
end

function MoveCellGroup:RemoveCells(notCreateBomb)
	if not notCreateBomb then
		local bomb, bombGrid = self:CreateSpecialCell();
		if bomb and bombGrid then
			bomb:InitAtGrid(bombGrid);
		end
	end
end

function MoveCellGroup:DebugLog()
	if isDebugBuild then
		PZPrint(">>>>>>>>>>type : " .. self.__cname .. "<<<<<<<<<<<<<")
		PZPrint(">>>>>>>>>>color : " .. self.color .. "<<<<<<<<<<<<<<<");
		PZPrint(">>>>>>>>>>cells : ");
		for i,v in ipairs(self:GetCells()) do
			PZPrint(tostring(v.position.x) .. ", " .. tostring(v.position.y));
		end
	end
end

function MoveCellGroup:CreateSpecialCell()
	
end

MoveCellGroupLine = class("MoveCellGroupLine", MoveCellGroup);

function MoveCellGroupLine:ctor(cell1, cell2, direction)
	MoveCellGroup.ctor(self);
	self.direction = direction;
	self.cells = {};
	table.insert(self.cells, cell1);
	table.insert(self.cells, cell2);
	self.color = cell1:GetColor();
end

function MoveCellGroupLine:Merge(group)
	if group.color ~= self.color then
		return nil;
	end

	if group:IsKindOfClass(MoveCellGroupLine) then
		local publicCells = self:GetPublicCells(group);
		if #publicCells > 0 then
			if group.direction == self.direction or math.abs(group.direction.index - self.direction.index) == 3 then
				for _, v in ipairs(group:GetCells()) do
					local isPublicCell = false;
					for _, vv in ipairs(publicCells) do 
						if v == vv then
							isPublicCell = true;
							break;
						end
					end
					if not isPublicCell then
						table.insert(self.cells, v);
					end
				end
				return self;
			else
				PZAssert(#publicCells == 1, "publicCells error")
				local newAngleGroup = MoveCellGroupSeveralLine.New({self, group});
				return newAngleGroup;
			end
		end
	elseif group:IsKindOfClass(MoveCellGroupSeveralLine) then
		return group:Merge(self);
	end
end

function MoveCellGroupLine:GetCells()
	return self.cells;
end

function MoveCellGroupLine:GetRemovable()
	if #self.cells < 3 then
		return false;
	end
	return true;
end

function MoveCellGroupLine:RemoveCells(notCreateBomb)
	if not self:GetRemovable() then
		return;
	end

	local cells = self:GetCells()
	for i,v in ipairs(cells) do
		local key = HexagonGrid.GetKeyFromPosition(v.position);
		local grid = Battle.instance.grids[key];
		grid:RemoveCell(self);
	end

	MoveCellGroup.RemoveCells(self, notCreateBomb);
end

function MoveCellGroupLine:CreateSpecialCell()
	if not self:GetRemovable() then
		return;
	end

	local cellsCount = #self:GetCells();
	if cellsCount <= 3 then
		return;
	end

	local bombGrid = nil;
	local sourceControl = Battle.instance.stepsQueen.currentNode.sourceControl;
	if sourceControl and sourceControl:IsKindOfClass(BattleControlExchange) then
		for i,v in ipairs(self:GetCells()) do
			if v:GetGrid() == sourceControl.grid then
				bombGrid = v:GetGrid();
				break;
			end
			if v:GetGrid() == sourceControl.grid:GetGridByDirection(sourceControl.direction) then
				bombGrid = v:GetGrid();
				break;
			end
		end
	end

	--TODO:如果有其他类型的操作，如：使用道具，也要判断是否有bombGrid

	local bomb = nil;
	if cellsCount == 4 then
		if not bombGrid then
			local sortedCells = self:GetSortedCells();
			bombGrid = sortedCells[2]:GetGrid();
		end
		local directionFactor = MoveCellLineBomb.ConvertDirectionToMetaIdFactor(self.direction);
		bomb = BattleElement.CreateElementByMetaId(20000 + directionFactor * 10 + MoveCell.Color[self.color].index);
	elseif  cellsCount >= 5 then
		if not bombGrid then
			local sortedCells = self:GetSortedCells();
			bombGrid = sortedCells[3]:GetGrid();
		end
		bomb = BattleElement.CreateElementByMetaId(20056);
	end

	return bomb, bombGrid;
end


function MoveCellGroupLine:GetSortedCells()
	local sortedCells = clone(self:GetCells());

	local cellsCount = #sortedCells;

	for i=1,cellsCount do
		for j=1,cellsCount do
			if sortedCells[i].position.y > sortedCells[j].position.y then
				local t = sortedCells[j];
				sortedCells[j] = sortedCells[i];
				sortedCells[i] = t;
			end
		end
	end

	return sortedCells;
end


MoveCellGroupSeveralLine = class("MoveCellGroupSeveralLine", MoveCellGroup)


function MoveCellGroupSeveralLine:ctor(lines)
	MoveCellGroup.ctor(self);
	self.lines = lines or {};
	if #self.lines then
		self.color = self.lines[1].color;
	end
end

function MoveCellGroupSeveralLine:GetCells()
	local ret = {};
	for _,l in ipairs(self.lines) do
		for _,v in ipairs(l:GetCells()) do
			table.insert(ret, v);
		end
	end
	return ret;
end



function MoveCellGroupSeveralLine:Merge(group)
	if group.color ~= self.color then
		return;
	end

	if group:IsKindOfClass(MoveCellGroupLine) then
		local f = false;
		local linesToAdd = {};
		for i,v in ipairs(self.lines) do
			local m = v:Merge(group)
			if m then
				if m == v then
					return self;
				else
					f = true;
				end
			end
		end

		if f then
			table.insert(self.lines, group);
			return self;
		end
	elseif group:IsKindOfClass(MoveCellGroupSeveralLine) then
		local f = false;
		local unmergeLines = {}
		for i,v in ipairs(group.lines) do
			local m = self:Merge(v);
			if m and m == self then
				f = true;
			else
				table.insert(unmergeLines, v);
			end
		end

		if f then
			for i,v in ipairs(unmergeLines) do
				table.insert(self.lines, v);
			end
			return self;
		end
	end
end

function MoveCellGroupSeveralLine:DebugLog()
	if isDebugBuild then
		PZPrint(">>>>>>>>>>type : " .. self.__cname .. "<<<<<<<<<<<<<")
		PZPrint(">>>>>>>>>>color : " .. self.color .. "<<<<<<<<<<<<<<<");
		PZPrint(">>>>>>>>>>lines : ");
		
		for i,v in ipairs(self.lines) do
			v:DebugLog();
		end
	end
end

function MoveCellGroupSeveralLine:GetRemovable()
	for i,v in ipairs(self.lines) do
		if v:GetRemovable() then
			return true;
		end
	end
end

function MoveCellGroupSeveralLine:RemoveCells(notCreateBomb)
	for i,v in ipairs(self.lines) do
		v:RemoveCells(true);
	end

	MoveCellGroup.RemoveCells(self, notCreateBomb);
end


function MoveCellGroupSeveralLine:CreateSpecialCell()
	local bomb, bombGrid = nil;
	for i,v in ipairs(self.lines) do
		local tBomb, tBombGrid = v:CreateSpecialCell();
		if tBomb and tBombGrid then
			bomb = tBomb;
			bombGrid = tBombGrid;
			if bomb:IsKindOfClass(MoveCellColorBomb) then
				return bomb, bombGrid;
			end
		end
	end

	for i,v in ipairs(self.lines) do
		if v:GetRemovable() then
			for ii,vv in ipairs(self.lines) do
				if vv:GetRemovable() then
					if v ~= vv then
						local publicCells = v:GetPublicCells(vv);
						if #publicCells > 0 then
							PZAssert(#publicCells == 1, "hahahah");
							bombGrid = publicCells[1]:GetGrid();
							bomb = BattleElement.CreateElementByMetaId(20000 + 40 + MoveCell.Color[self.color].index);
							return bomb, bombGrid;
						end
					end
				end
			end
		end
	end

	return bomb, bombGrid;
end
