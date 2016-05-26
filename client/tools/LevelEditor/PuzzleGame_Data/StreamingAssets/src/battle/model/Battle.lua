require "battle.events.BattleSteps"

Battle = class("Battle", PZClass);

Battle.instance = nil;

function Battle:ctor(levelMetaId)
	math.randomseed(1);
	self.levelMeta = nil;
	self.grids = {};
	self.score = 0;
	self.round = 0;
	self.remainderSecounds = 0;
	self.runningCellCount = 0;
	self.stepsQueen = PZQueen.New();
	self.stepsQueen.OnFinished = function ()
	end
end

function Battle:Clean()
	for _,v in pairs(self.grids) do
		v:Clean();
	end

	self.stepsQueen:Clean();
end

function Battle:InitWithLevelMetaId(levelMetaId)
	self.levelMeta = LevelMeta[levelMetaId];

	self:InitGrids();

	local alertCells = nil;
	local f = true;
	while f do
		self:RerangeCells();
		local exchangable = false;
		exchangable, alertCells = self:CheckExchangable();
		if exchangable then
			f = false;
		end
	end

	for k,v in pairs(self.grids) do
		if v.cell and v.cell.isInitCell then
			v.cell.isInitCell = nil;
		end
	end

	local ws = WaitingControlStep.New();
	ws.alertCells = alertCells;
	self.stepsQueen:Launch(ws);
end

function Battle:InitGrids()
	local refreshRate = self.levelMeta.refreshRate;
	if not refreshRate then
		refreshRate = {["red"] = 100, ["orange"] = 100, ["green"] = 100, ["blue"] = 100, ["purple"] = 100};
	end
	local refreshRateSum = 0;
	local refreshColors = {};
	for k,v in pairs(refreshRate) do
		refreshRateSum = refreshRateSum + v;
		table.insert(refreshColors, k);
	end

	local randomOffset = math.random(0, #refreshColors - 1);

	self.GetRandomElementMetaId = function()
		local randomRate = math.random(0, refreshRateSum - 1);
		local tempSum = 0;
		for i,k in ipairs(refreshColors) do
			local v = refreshRate[k];
			tempSum = tempSum + v;
			if tempSum > randomRate then
				local color = refreshColors[(i - 1 + randomOffset) % #refreshColors + 1];
				local metaId = MoveCell.Color[color].index + 20000
				return metaId;
			end
		end 
	end

	for k,v in pairs(self.levelMeta.map) do
		local grid = BattleElement.CreateElementByMetaId(v.grid);
		grid:SetPosition(HexagonGrid.GetPositionFromKey(k));

		if v.block then
			local block = BattleElement.CreateElementByMetaId(v.block);
			grid:SetBlock(block);
		end

		if not grid.block or grid.block:GetCellContainable() then
			if v.cell then
				local cell = nil;
				if ElementMeta[v.cell].color ~= "mix" then
					local index = table.getIndex(refreshColors, ElementMeta[v.cell].color) - 1;
					local offsetIndex = (index + randomOffset) % #refreshColors + 1;
					local offsetColor = refreshColors[offsetIndex];
					local offsetMetaId = MoveCell.Color[offsetColor].index + math.modf(v.cell / 10) * 10;
					cell = BattleElement.CreateElementByMetaId(offsetMetaId);
				else
					cell = BattleElement.CreateElementByMetaId(v.cell);
				end
				cell.isInitCell = true;
				grid:SetCell(cell);
			else
				local randomElementMetaId = self:GetRandomElementMetaId();
				local cell = BattleElement.CreateElementByMetaId(randomElementMetaId);
				grid:SetCell(cell);
			end
		end

		self.grids[k] = grid;
	end
end

function Battle:ExchangeCells(grid1, grid2)
	PZAssert(grid1.cell, "grid1.cell is nil");
	PZAssert(grid2.cell, "grid2.cell is nil");
	PZAssert(not grid1.block or grid1.block:GetCellMoveable(), "grid1.block not moveable");
	PZAssert(not grid2.block or grid2.block:GetCellMoveable(), "grid2.block not moveable");
	local tCell = grid2.cell;
	grid2:SetCell(grid1.cell);
	grid1:SetCell(tCell);
end

function Battle:ExchangeCellToDirection(grid, direction)
	local grid1 = grid;
	local cell1 = grid1.cell;
	local grid2 = grid:GetGridByDirection(direction);
	local cell2 = grid2.cell;
	self:ExchangeCells(grid1, grid2);

	local e = CellExchangedEvent.New();
	e.fromGrid = grid1;
	e.toGrid = grid2;
	e.cell = cell1;
	e.cell.eventQueen:Append(e);

	local e2 = CellExchangedEvent.New();
	e2.fromGrid = grid2;
	e2.toGrid = grid1;
	e2.cell = cell2;
	e2.cell.eventQueen:Append(e2);
end

function Battle:CancelExchange(grid, direction)
	local grid1 = grid;
	local cell1 = grid1.cell;
	local grid2 = grid:GetGridByDirection(direction);
	local cell2 = grid2.cell;
	self:ExchangeCells(grid1, grid2);

	local e = CellExchangeCanceledEvent.New();
	e.fromGrid = grid1;
	e.toGrid = grid2;
	e.cell = cell1;
	e.cell.eventQueen:Append(e);

	local e2 = CellExchangeCanceledEvent.New();
	e2.fromGrid = grid2;
	e2.toGrid = grid1;
	e2.cell = cell2;
	e2.cell.eventQueen:Append(e2);
end

function Battle:CheckOutRemovableGroups()
	local groups = {};
	
	for k,v in pairs(Battle.instance.grids) do
		if v.cell then
			v.cell:CheckOutGroups(groups);
		end
	end

	local toRemoveGroups = {};
	local toAddGroups = {};
	for i,v in ipairs(groups) do
		if not table.find(toRemoveGroups, i) then
			for ii,vv in ipairs(groups) do
				if not table.find(toRemoveGroups, ii) then
					if v ~= vv then
						local m = v:Merge(vv);
						if m then
							if m == v then
								table.insert(toRemoveGroups, ii);
							elseif m == vv then
								table.insert(toRemoveGroups, i);
								break;
							else
								table.insert(toRemoveGroups, ii);
								table.insert(toRemoveGroups, i);
								table.insert(toAddGroups, m);
								break;
							end
						end
					end
				end
			end
		end
	end

	for i,v in ipairs(toRemoveGroups) do
		table.remove(groups, v);
	end

	for i,v in ipairs(toAddGroups) do
		table.insert(groups, v);
	end


	local removableGroups = {};
	for i,v in ipairs(groups) do
		if v:GetRemovable() then
			table.insert(removableGroups, v);
		end
	end

	return removableGroups;
end

function Battle:RemoveGroups(groups)
	for i,v in ipairs(groups) do
		if v:GetRemovable() then
			v:RemoveCells();
		end
	end
end

function Battle:ResetGrids()
	local full = false;

	while not full do
		full = true;
		for k,v in pairs(self.grids) do
			if not v.cell  and (not v.block or v.block:GetCellContainable()) and v:Reset() then
				full = false;
			end 
		end
	end
end


function Battle:OnCellEventQueenLaunch(cell)
	
	self.runningCellCount = self.runningCellCount + 1;
end

function Battle:OnCellEventQueenFinish(cell)
	if self.runningCellCount == 0 then
		PZAssert(false ,"bbbbbb");
	end
	
	self.runningCellCount = self.runningCellCount - 1;
	if self.runningCellCount <= 0 then
		self.runningCellCount = 0;
		self.stepsQueen:StepNext();
	end


end

function Battle:RerangeCells(sendEvent)
	local cells = {};

	local rf = true;

	while rf do
		rf = false;

		for k,v in pairs(self.grids) do
			if v.cell and not v.cell.isInitCell and (not v.block or (v.block:GetCellContainable() and v.block:GetCellMoveable())) then
				table.insert(cells, v.cell);
				v.cell = nil;
			end
		end

		for k,v in pairs(self.grids) do
			if not v.cell and (not v.block or (v.block:GetCellContainable() and v.block:GetCellMoveable()))then
				local randomIndex = math.random(1, #cells);
				for i = 1, #cells do
					local ri = (i + randomIndex - 1) % #cells + 1;
					local randomCell = cells[ri];
					v:SetCell(randomCell);
					local gs = self:CheckOutRemovableGroups();
					if #gs == 0 then
						table.remove(cells, ri);
						break;
					else
						v.cell = nil;
					end
				end

				if not v.cell then
					rf = true;
					break;
				end
			end
		end

	end


	if sendEvent then
		for k,v in pairs(self.grids) do
			if v.cell then
				local e = CellRerangeEvent.New();
				e.cell = v.cell;
				v.cell.eventQueen:Append(e);
			end
		end
	end
end

function Battle:CheckExchangable()
	for _,v in pairs(Battle.instance.grids) do
		if v.cell and (not v.block or v.block:GetCellMoveable()) then
			for _, d in pairs(HexagonGrid.Direction) do
				local grid1 = v;
				local grid2 = v:GetGridByDirection(d);
				if grid2 and (not grid2.block or grid2.block:GetCellMoveable()) then
					local cell1 = grid1.cell;
					local cell2 = grid2.cell;

					if cell1 and cell2 then
						if cell1:IsKindOfClass(MoveCellBomb) and cell2:IsKindOfClass(MoveCellBomb) then
							return true, {cell1, cell2};
						end

						if cell1:IsKindOfClass(MoveCellColorBomb) or cell2:IsKindOfClass(MoveCellColorBomb) then
							return true, {cell1, cell2};
						end

						if cell1 and cell2 then
							self:ExchangeCells(grid1, grid2);

							local groups = {};
							cell2:CheckOutGroups(groups);
							for _,g in ipairs(groups) do
								if g:GetRemovable() then
									self:ExchangeCells(grid1, grid2);
									return true, g:GetCells();
								end
							end

							self:ExchangeCells(grid1, grid2);
						end
					end
				end
			end
		end
	end

	return false;
end


BattleElement = class("BattleElement", PZClass);

local kMaxBattleElementId = 0;

function BattleElement.CreateElementByMetaId(elementMetaId)
	local r = nil;
	local meta = ElementMeta[elementMetaId];
	if meta.type == "grid" then
		if meta.name == "grid_normal" then
			r = HexagonGridNormal.New(elementMetaId);
		elseif meta.name == "grid_generator" then
			r = HexagonGridGenerator.New(elementMetaId);
		end
	elseif meta.type == "cell" then
		if string.sub(meta.name, -6) == "normal" then
			r = MoveCellNormal.New(elementMetaId);
		elseif string.sub(meta.name, -5) == "vBomb" then
			r = MoveCellLineBomb.New(elementMetaId);
			r.direction = HexagonGrid.Direction.Top;
		elseif string.sub(meta.name, -5) == "lBomb" then
			r = MoveCellLineBomb.New(elementMetaId);
			r.direction = HexagonGrid.Direction.UpLeft;
		elseif string.sub(meta.name, -5) == "rBomb" then
			r = MoveCellLineBomb.New(elementMetaId);
			r.direction = HexagonGrid.Direction.UpRight;
		elseif string.sub(meta.name, -5) == "aBomb" then
			r = MoveCellAreaBomb.New(elementMetaId);
		elseif meta.name == "cell_mix" then
			r = MoveCellColorBomb.New(elementMetaId);
		end
	elseif meta.type == "block" then
		r = Block.New(elementMetaId);
	end
	return r;
end

function BattleElement:SetPosition(position)
	self.position.x = position.x;
	self.position.y = position.y;
end

function BattleElement:ctor(metaId)
	self.elementId = kMaxBattleElementId + 1;
	kMaxBattleElementId = self.elementId;
	self.metaId = metaId;
	self.position = { x = 0 , y = 0 };
end

require "battle.model.HexagonGrid"
require "battle.model.MoveCell"
require "battle.model.MoveCellGroup"
require "battle.model.Block";
