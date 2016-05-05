

Battle = class("Battle", PZClass);

Battle.instance = nil;

function Battle:ctor()
	self.grids = {};
	self.score = 0;
	self.round = 0;
	self.remainderSecounds = 0;
end


function Battle:CheckOutGroups()
	local groups = {};
	for k,v in pairs(self.grids) do
		local cell = v.cell;
		cell:CheckOutGroups(groups);
	end
end