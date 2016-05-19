require "base.PZQueen"
require "battle.events.BattleControl"

BattleStep = class("BattleStep", PZQueenNode)

RerangeCellsStep = class("RerangeCellsStep", BattleStep);
function RerangeCellsStep:ctor()
	BattleStep.ctor(self);
end

function RerangeCellsStep:OnStepInto()
	Battle.instance:RerangeCells(true);

	local nextNode = CheckExchangableStep.New();
	self.queen:Insert(self, nextNode);
	self.queen:StepNext();
end

CheckExchangableStep = class("CheckExchangableStep", BattleStep);
function CheckExchangableStep:ctor()
	BattleStep.ctor(self);
end

function CheckExchangableStep:OnStepInto()
	local nextNode = nil;
	local exchangable, alertCells = Battle.instance:CheckExchangable();
	if exchangable then
		nextNode = WaitingControlStep.New();
		nextNode.alertCells = alertCells;
	else
		nextNode = RerangeCellsStep.New();
	end
	self.queen:Insert(self, nextNode);
	self.queen:StepNext();
end



WaitingControlStepIntoEvent = class("WaitingControlStepEvent", PZEvent);

WaitingControlStep = class("WaitingControlStep", BattleStep)

function WaitingControlStep:ctor()
	BattleStep.ctor(self);
	self.control = nil;
	self.alertCells = nil;
	self.alertTimer = nil;
end

function WaitingControlStep:Clean()
	BattleStep.Clean(self);
	if self.alertTimer then
		self.alertTimer:Stop();
		self.alertTimer = nil;
	end
end

function WaitingControlStep:OnStepInto()
	local e = WaitingControlStepIntoEvent.New();
	e:Happen();

	BattleControl.enabled = true;
	BattleControlExchange:AddBeforeHandler(self.BattleControlExchangeHandler, self, 0)

	self.alertTimer = Timer.New(function()
		for i,v in ipairs(self.alertCells) do
			local e = CellAlertEvent.New();
			e.cell = v;
			e:Happen();
		end
	end, 5, -1);
	self.alertTimer:Start();
end

function WaitingControlStep:OnStepOut()
	BattleControlExchange:RemoveBeforeHandler(self.BattleControlExchangeHandler, self, 0)
	BattleControl.enabled = false;
	self.alertTimer:Stop();
	self.alertTimer = nil;
end

function WaitingControlStep:BattleControlExchangeHandler(c)
	self.control = c;
	
	if self.control:IsKindOfClass(BattleControlExchange) then

		local grid1 = self.control.grid;
		local grid2 = self.control.grid:GetGridByDirection(self.control.direction);
		local cell1 = grid1.cell;
		local cell2 = grid2.cell;
		local gridGroup = cell1:GetGridGroupWithCell(cell2);

		if gridGroup then
			local nextNode = RemoveGridGroupStep.New();
			nextNode.gridGroup = gridGroup;
			self.queen:Insert(self, nextNode);
		else
			local nextNode = CheckOutGroupsStep.New();
			self.queen:Insert(self, nextNode);
		end

	end
end

RemoveGridGroupStep = class("RemoveGridGroupStep", BattleStep);

function RemoveGridGroupStep:ctor()
	BattleStep.ctor(self);
	self.gridGroup = nil;
end

function RemoveGridGroupStep:OnStepInto()
	if self.gridGroup:IsKindOfClass(HexagonGridGroupColorConvert) then
		local nextNode = RemoveAllBombStep.New();
		self.queen:Insert(self, nextNode);
	else
		local nextNode = ResetGridsStep.New();
		self.queen:Insert(self, nextNode);
	end

	self.gridGroup:RemoveGridsCell();
end


RemoveAllBombStep = class("RemoveAllBombStep", BattleStep);

function RemoveAllBombStep:ctor()
	BattleStep.ctor(self);
end

function RemoveAllBombStep:OnStepInto()

	local nextNode = ResetGridsStep.New();
	self.queen:Insert(self, nextNode);

	for k,v in pairs(Battle.instance.grids) do 
		if v.cell and v.cell:IsKindOfClass(MoveCellBomb) then
			v:RemoveCell();
		end 
	end
end

CheckOutGroupsStep = class("CheckOutGroupsStep", BattleStep)

function CheckOutGroupsStep:ctor()
	BattleStep.ctor(self);
	self.groups = nil;
end

function CheckOutGroupsStep:OnStepInto()
	local removableGroups = Battle.instance:CheckOutRemovableGroups();
	if #removableGroups <= 0 then
		if self.preNode:IsKindOfClass(WaitingControlStep) then
			if self.preNode.control:IsKindOfClass(BattleControlExchange) then
				Battle.instance:CancelExchange(self.preNode.control.grid, self.preNode.control.direction);
				local nextNode = WaitingControlStep.New();
				nextNode.alertCells = self.preNode.alertCells;
				self.queen:Insert(self, nextNode);
				return;
			end
		elseif self.preNode:IsKindOfClass(ResetGridsStep) then

			local tempRoundStep = nil;
			local roundSteps = {}
			for k, v in pairs(Battle.instance.grids) do
				if v.block then
					local stepName = ElementMeta[v.block.metaId].round_step;
					if stepName and _G[stepName] and not roundStepBlockMetaIds[v.block.metaId] then 
						tempRoundStep = _G[stepName].New();
						tempRoundStep.blockMetaId = v.block.metaId;
						roundSteps[v.block.metaId] = tempRoundStep;
						self.queen:Insert(self, nextNode);
					end
				end
			end

			local nextNode = CheckExchangableStep.New();

			if tempRoundStep then
				self.queen:Insert(tempRoundStep, nextNode);
			else
				self.queen:Insert(self, nextNode);
			end
		end
	else
		self.groups = removableGroups;
		local nextNode = RemoveGroupsStep.New();
		nextNode.groups = self.groups;
		if self.preNode:IsKindOfClass(WaitingControlStep) then
			nextNode.sourceControl = self.preNode.control;
		end
		self.queen:Insert(self, nextNode);
	end

	self.queen:StepNext();
end

function CheckOutGroupsStep:OnStepOut()
	
end



RemoveGroupsStep = class("RemoveGroupsStep", BattleStep);

function RemoveGroupsStep:ctor()
	BattleStep.ctor(self);
	self.groups = nil;
	self.sourceControl = nil;
end

function RemoveGroupsStep:OnStepInto()

	local nextNode = ResetGridsStep.New();
	self.queen:Insert(self, nextNode);

	Battle.instance:RemoveGroups(self.groups);
end

function RemoveGroupsStep:OnStepOut()
	
end


ResetGridsStep = class("ResetGridsStep", BattleStep);

function ResetGridsStep:ctor()
	BattleStep.ctor(self);
end

function ResetGridsStep:Clean()
	BattleStep.Clean(self);
end

function ResetGridsStep:OnStepInto()
	local nextNode = CheckOutGroupsStep.New();
	self.queen:Insert(self, nextNode);

	Battle.instance:ResetGrids();
	if Battle.instance.runningCellCount <= 0 then
		self.queen:StepNext();
	end
end


function ResetGridsStep:OnStepOut()
	for k,v in pairs(Battle.instance.grids) do
		if v.cell then
			v.cell.dropDistance = 0;
		end
	end
end


BlockGrowStep = class("BlockGrowStep", BattleStep);


function BlockGrowStep:ctor()
	BattleStep.ctor(self);
	self.blockMetaId = 0;
end

function BlockGrowStep:Clean()
	BattleStep.Clean(self);
end

function BlockGrowStep:OnStepInto()
	if not Block.kRemovedBlockMetaIds[self.blockMetaId] then
		local firstPriorityGrids = {};
		local secoundPriorityGrids = {};
		for k,v in pairs(Battle.instance.grids) do
			if v.block and v.block.metaId == self.blockMetaId then
				for _,d in ipairs(HexagonGrid.Directions) do
					local otherGrid = v:GetGridByDirection(d);
					if otherGrid and not otherGrid.block and otherGrid.cell then
						if otherGrid.cell:IsKindOfClass(MoveCellBomb) or otherGrid:IsKindOfClass(HexagonGridGenerator) then
							table.insert(secoundPriorityGrids, otherGrid);
						else
							table.insert(firstPriorityGrids, otherGrid);
						end
					end
				end
			end
		end

		if #firstPriorityGrids > 0 then
			local randomIndex = math.random(1, #firstPriorityGrids);
			local randomGrid = firstPriorityGrids[randomIndex];

		elseif #secoundPriorityGrids > 0 then
			local randomIndex = math.random(1, #secoundPriorityGrids);
			local randomGrid = secoundPriorityGrids[randomIndex];
			
		end
	end

	self.queen:StepNext();
end

function BlockGrowStep:OnStepOut()
	BattleStep.kRemovedBlockMetaIds[self.blockMetaId] = nil;
end

