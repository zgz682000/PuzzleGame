

MoveCell = class("MoveCell", PZClass);

MoveCell.Color = {
	None = 0,
	Mix = 10
}

function MoveCell:ctor()
	self.position = { x = 0 , y = 0 };
	self.color = MoveCell.Color.None;
end

function MoveCell:GetGrid()
	local key = HexagonGrid.GetKeyFromPosition(self.position);
	return Battle.instance.grids[key];
end


function MoveCell:CheckOutGroups(groups)
	local selfGrid = self:GetGrid();
	for i,v in ipairs(HexagonGrid.Directions) do
		local otherDirection = HexagonGrid.Direction[v];
		local otherPosition = selfGrid:GetPositionByDirection(otherDirection);
		local otherKey = HexagonGrid.GetKeyFromPosition(otherPosition);
		local otherGrid = Battle.instance.grids[otherKey];
		if otherGrid then
			local otherCell = otherGrid.cell;
			if otherCell and otherCell.color == self.color then
				local groupLine = MoveCellGroupLine.New(self, otherCell, otherDirection);
				for ii,vv in ipairs(groups) do
					local newGroup = vv:Merge(groupLine); 
					if not newGroup then
						table.insert(groups, groupLine);
					elseif newGroup ~= vv then
						groups[ii] = newGroup;
					end
				end
			end
		end
	end
end

