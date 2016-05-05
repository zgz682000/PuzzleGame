

MoveCellGroup = class("MoveCellGroup", PZClass);

function MoveCellGroup:ctor()
	self.cells = {};
end


function MoveCellGroup:Merge(group)

end

function MoveCellGroup:GetCells()
	return self.cells;
end

function MoveCellGroup:GetPublicCell(group)
	for _,v1 in ipairs(self:GetCells()) do
		for _,v2 in ipairs(group:GetCells()) do
			if v1 == v2 then
				return v1;
			end
		end
	end
end

MoveCellGroupLine = class("MoveCellGroupLine", MoveCellGroup);

function MoveCellGroupLine:ctor(cell1, cell2, direction)
	MoveCellGroup.ctor(self);
	self.direction = direction;
	table.insert(self.cells, cell1);
	table.insert(self.cells, cell2);
end

function MoveCellGroupLine:Merge(group)
	if group:IsKindOfClass(MoveCellGroupLine) then
		local publicCell = self:GetPublicCell(group);
		if publicCell then
			if group.direction == self.direction or math.abs(group.direction.index - self.direction.index) == 3 then
				for _, v in ipairs(group:GetCells()) do
					if v ~= publicCell then
						table.insert(self.cells, v);
					end
				end
				return self;
			else
				local newAngleGroup = MoveCellGroupAngle.New(self, group, publicCell);
				return newAngleGroup;
			end
		end
	elseif group:IsKindOfClass(MoveCellGroupAngle) then
		return group:Merge(self);
	end
end


MoveCellGroupAngle = class("MoveCellGroupAngle", MoveCellGroup);

function MoveCellGroupAngle:ctor(line1, line2, publicCell)
	MoveCellGroup.ctor(self);
	self.line1 = line1;
	self.line2 = line2;
	self.publicCell = publicCell;
end

function MoveCellGroupAngle:Merge(group)
	if group:IsKindOfClass(MoveCellGroupLine) then
		local lineMerge1 = self.line1:Merge(group);
		if lineMerge1 == self.line1 then
			return self;
		end

		local lineMerge2 = self.line2:Merge(group);
		if lineMerge2 == self.line2 then
			return self;
		end
	end
end

function MoveCellGroup:GetCells()
	local ret = {};
	for _,v in ipairs(self.line1:GetCells()) do
		table.insert(ret, v);
	end
	for _,v in ipairs(self.line2:GetCells()) do
		table.insert(ret, v);
	end
end

