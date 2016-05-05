
HexagonGrid = class("HexagonGrid", PZClass);

HexagonGrid.Directions = {"Top", "UpRight", "DownRight", "Bottom", "DownLeft", "UpLeft"}

HexagonGrid.Direction = {
	Top = { --上边
		index = 1,
		positionOffset = {
			x = 0,
			y = -0.866
		},
	}, 
	UpRight = {
		index = 2,
		positionOffset = {
			x = 0.75,
			y = -0.433,
		}
	},
	DownRight = {
		index = 3,
		positionOffset = {
			x = 0.75,
			y = 0.433,
		}
	},
	Bottom = {
		index = 4,
		positionOffset = {
			x = 0,
			y = 0.866,
		}
	},
	DownLeft = {
		index = 5,
		positionOffset = {
			x = -0.75,
			y = 0.433,
		}
	},
	UpLeft = {
		index = 6,
		positionOffset = {
			x = -0.75,
			y = -0.433,
		}
	}
}


function HexagonGrid:ctor()
	self.position = { x = 0 , y = 0 };
	self.cell = nil;
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
	return position.x * 10000000 + position.y * 1000
end

function HexagonGrid.GetPositionFromKey(key)
	local x = math.modf(key / 10000) / 1000;
	local y = key % 10000 / 1000;
	return {x = x, y = y};
end


