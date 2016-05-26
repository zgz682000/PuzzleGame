

HexagonGridGroup = class("HexagonGridGroup", PZClass);

function HexagonGridGroup:RemoveGridsCell()
	local grids = self:GetGrids();
	if not grids then
		return;
	end

	for k,v in pairs(grids) do
		v:RemoveCell(self);
	end
end

function HexagonGridGroup:GetGrids()
	
end

HexagonGridGroupLines = class("HexagonGridGroupLines", HexagonGridGroup);

function HexagonGridGroupLines:ctor()
	self.locations = {};
end

function HexagonGridGroupLines:AddLocation(centerGrid, direction)
	table.insert(self.locations, {centerGrid = centerGrid, direction = direction});
end

function HexagonGridGroupLines:GetGrids()
	local ret = {};

	for i,v in ipairs(self.locations) do
		if v.direction ~= HexagonGrid.Direction.Top and v.direction ~=HexagonGrid.Direction.Bottom then
			local a = v.direction.positionOffset.y / v.direction.positionOffset.x;
			local b = v.centerGrid.position.y - a * v.centerGrid.position.x;
			local preventBlockGrid = nil;
			local lineGrids = {};
			for k,g in pairs(Battle.instance.grids) do
				if math.abs(g.position.y - (a * g.position.x + b)) < 0.0001 then
					ret[k] = g;
					table.insert(lineGrids, g);
					if g.block and g.block:GetPreventLineBomb() then
						preventBlockGrid = g;
					end
				end
			end

			if preventBlockGrid then
				if preventBlockGrid.position.y > v.centerGrid.position.y then
					for _,g in ipairs(lineGrids) do
						if g.position.y >= preventBlockGrid.position.y then
							ret[g:GetKey()] = nil;
						end
					end
				elseif preventBlockGrid.position.y < v.centerGrid.position.y then
					for _,g in ipairs(lineGrids) do
						if g.position.y <= preventBlockGrid.position.y then
							ret[g:GetKey()] = nil;
						end
					end
				end
			end
		else
			local preventBlockGrid = nil;
			local lineGrids = {};
			for k,g in pairs(Battle.instance.grids) do
				if g.position.x == v.centerGrid.position.x then
					ret[k] = g;
					table.insert(lineGrids, g);
					if g.block and g.block:GetPreventLineBomb() then
						preventBlockGrid = g;
					end
				end
			end

			if preventBlockGrid then
				if preventBlockGrid.position.y > v.centerGrid.position.y then
					for _,g in ipairs(lineGrids) do
						if g.position.y >= preventBlockGrid.position.y then
							ret[g:GetKey()] = nil;
						end
					end
				elseif preventBlockGrid.position.y < v.centerGrid.position.y then
					for _,g in ipairs(lineGrids) do
						if g.position.y <= preventBlockGrid.position.y then
							ret[g:GetKey()] = nil;
						end
					end
				end
			end
		end
	end
	return ret;
end

HexagonGridGroupArea = class("HexagonGridGroupArea", HexagonGridGroup);

function HexagonGridGroupArea:ctor()
	self.centerGrid = nil;
	self.radius = 1;
end

function HexagonGridGroupArea:GetGrids()
	local ret = {[self.centerGrid:GetKey()] = self.centerGrid};
	local preLoopGrids = {[self.centerGrid:GetKey()] = self.centerGrid};
	for j=1, self.radius do
		local cRet = clone(preLoopGrids);
		preLoopGrids = {};
		for i,d in ipairs(HexagonGrid.Directions) do
			for k,g in pairs(cRet) do
				for l=0, j - 1 do
					local od = HexagonGrid.Directions[(i + l - 1) % 6 + 1];
					local og = g:GetGridByDirection(od);
					if og then
						ret[og:GetKey()] = og;
						preLoopGrids[og:GetKey()] = og;
					end
				end
			end
		end
	end
	return ret;
end

HexagonGridGroupColor = class("HexagonGridGroupColor", HexagonGridGroup);

function HexagonGridGroupColor:ctor()
	self.centerGrid = nil;
	self.color = nil;
end

function HexagonGridGroupColor:GetGrids()
	local ret = {};
	for k,v in pairs(Battle.instance.grids) do
		if v.cell and v.cell:GetColor() == self.color then
			ret[k] = v;
		end
	end
	ret[self.centerGrid:GetKey()] = self.centerGrid;
	return ret;
end

HexagonGridGroupColorConvert = class("HexagonGridGroupColorConvert", HexagonGridGroupColor);

function HexagonGridGroupColorConvert:ctor()
	HexagonGridGroupColor.ctor(self);
	self.otherBomb = nil;
end

function HexagonGridGroupColorConvert:RemoveGridsCell()
	local grids = self:GetGrids();
	for k,v in pairs(grids) do
		if v == self.centerGrid then
			v:RemoveCell(self);
		else
			if self.otherBomb:IsKindOfClass(MoveCellLineBomb) then
				local random = math.random(1,3);
				local directionFactor = MoveCellLineBomb.ConvertDirectionToMetaIdFactor(HexagonGrid.Directions[random]);
				local convertBomb = BattleElement.CreateElementByMetaId(20000 + directionFactor * 10 + MoveCell.Color[self.color].index);
				v:ConvertCell(convertBomb);
			elseif self.otherBomb:IsKindOfClass(MoveCellAreaBomb) then
				local convertBomb = BattleElement.CreateElementByMetaId(20000 + 40 + MoveCell.Color[self.color].index);
				v:ConvertCell(convertBomb);
			end
		end
	end
end


HexagonGridGroupAll = class("HexagonGridGroupAll", HexagonGridGroup);

function HexagonGridGroupAll:ctor()
	
end

function HexagonGridGroupAll:GetGrids()
	return Battle.instance.grids;
end




