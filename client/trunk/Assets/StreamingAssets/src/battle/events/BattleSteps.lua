require "base.PZQueen"
require "battle.events.BattleControl"

BattleStep = class("BattleStep", PZQueenNode)

EndRoundStep = class("EndRoundStep", BattleStep)
function EndRoundStep:ctor()
	BattleStep.ctor(self);
end

function EndRoundStep:OnStepInto()
	self.queen.currentRoundOver = true;

	local tempRoundStep = nil;
	local roundSteps = {}
	local needAutoDecrease = false;
	for _, v in ipairs(Battle.instance.sortedGrids) do
		if v.block and not roundSteps[v.block.metaId] then 
			local stepName = ElementMeta[v.block.metaId].round_step;
			if stepName and _G[stepName]  then
				tempRoundStep = _G[stepName].New();
				tempRoundStep.blockMetaId = v.block.metaId;
				roundSteps[v.block.metaId] = tempRoundStep;
				self.queen:Append(tempRoundStep);
			end

			if v.block:GetAutoDecrease() then
				needAutoDecrease = true;
			end
		end
	end 

	if needAutoDecrease then
		tempRoundStep = BlockAutoDecreaseStep.New();
		self.queen:Append(tempRoundStep);
	end

	local nextNode = BeginRoundStep.New();

	if tempRoundStep then
		self.queen:Append(nextNode);
	else
		self.queen:Insert(self, nextNode);
	end
	self.queen:StepNext();
end

BeginRoundStep = class("BeginRoundStep", BattleStep);
function BeginRoundStep:ctor()
	BattleStep.ctor(self);
end

function BeginRoundStep:OnStepInto()
	self.queen.currentRoundOver = false;

	Battle.instance.combo = 0;

	local nextNode = CheckExchangableStep.New();
	self.queen:Insert(self, nextNode);
	self.queen:StepNext();
end

RerangeCellsStep = class("RerangeCellsStep", BattleStep);
function RerangeCellsStep:ctor()
	BattleStep.ctor(self);
end

function RerangeCellsStep:OnStepInto()
	Battle.instance:RerangeCells(true);

	local nextNode = CheckExchangableStep.New();
	self.queen:Insert(self, nextNode);
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
	BattleControlExchange:RemoveBeforeHandler(self.BattleControlExchangeHandler, self, 0)
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



	Battle.instance.combo = Battle.instance.combo + 1;

	self.gridGroup:RemoveGridsCell();
end


RemoveAllBombStep = class("RemoveAllBombStep", BattleStep);

function RemoveAllBombStep:ctor()
	BattleStep.ctor(self);
end

function RemoveAllBombStep:OnStepInto()

	local nextNode = ResetGridsStep.New();
	self.queen:Insert(self, nextNode);

	for _,v in ipairs(Battle.instance.sortedGrids) do 
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
		elseif self.preNode:IsKindOfClass(ResetGridsStep) and not self.queen.currentRoundOver then

			local nextNode = EndRoundStep.New();
			self.queen:Insert(self, nextNode);

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
	

	Battle.instance.combo = Battle.instance.combo + 1;

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
	for _,v in ipairs(Battle.instance.sortedGrids) do
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
		for _,v in ipairs(Battle.instance.sortedGrids) do
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
			local randomIndex = ReplayManager.GetRandom(1, #firstPriorityGrids);
			local randomGrid = firstPriorityGrids[randomIndex];
			local newBlock = BattleElement.CreateElementByMetaId(self.blockMetaId);
			newBlock:Grow(randomGrid);
		elseif #secoundPriorityGrids > 0 then
			local randomIndex = ReplayManager.GetRandom(1, #secoundPriorityGrids);
			local randomGrid = secoundPriorityGrids[randomIndex];
			local newBlock = BattleElement.CreateElementByMetaId(self.blockMetaId);
			newBlock:Grow(randomGrid);
		end
	end

	self.queen:StepNext();
end

function BlockGrowStep:OnStepOut()
	Block.kRemovedBlockMetaIds[self.blockMetaId] = nil;
end


BlockMoveStep = class("BlockMoveStep", BattleStep);

function BlockMoveStep:ctor()
	BattleStep.ctor(self);
	self.blockMetaId = 0;
	self.moveblockCount = 0;
end

function BlockMoveStep:OnStepInto()
	local movedBlock = {};
	for _,v in ipairs(Battle.instance.sortedGrids) do
		if v.block and v.block.metaId == self.blockMetaId and not movedBlock[v.block.elementId] then
			movedBlock[v.block.elementId] = v.block;
			local firstPriorityGrids = {};
			local secoundPriorityGrids = {};
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

			if #firstPriorityGrids > 0 then
				local randomIndex = ReplayManager.GetRandom(1, #firstPriorityGrids);
				local randomGrid = firstPriorityGrids[randomIndex];
				v.block:Move(randomGrid);
				self.moveblockCount = self.moveblockCount + 1;
			elseif #secoundPriorityGrids > 0 then
				local randomIndex = ReplayManager.GetRandom(1, #secoundPriorityGrids);
				local randomGrid = secoundPriorityGrids[randomIndex];
				v.block:Move(randomGrid);
				self.moveblockCount = self.moveblockCount + 1;
			end
		end
	end

	if self.moveblockCount ~= 0 then
		local nextStep = CheckOutGroupsStep.New();
		self.queen:Insert(self,nextStep);
	else
		self.queen:StepNext();
	end
end

BlockReorderAroundCellsStep = class("BlockReorderAroundCellsStep", BattleStep)

function BlockReorderAroundCellsStep:ctor()
	BattleStep.ctor(self);
	self.blockMetaId = 0;
end

function BlockReorderAroundCellsStep:OnStepInto()
	local needCheck = false; 
	for _,v in ipairs(Battle.instance.sortedGrids) do
		if v.block and v.block.metaId == self.blockMetaId then
			local availibleGrids = {};
			for _,d in ipairs(HexagonGrid.Directions) do
				local otherGrid = v:GetGridByDirection(d);
				if otherGrid and not otherGrid.block and otherGrid.cell then
					table.insert(availibleGrids, otherGrid);
				end
			end

			if #availibleGrids > 1 then
				local tempCell = availibleGrids[1].cell;
				needCheck = true;
				for i = 2, #availibleGrids do
					local toGrid = availibleGrids[i - 1];
					local fromGrid = availibleGrids[i];
					fromGrid.cell:Reorder(toGrid);
				end
				tempCell:Reorder(availibleGrids[#availibleGrids]);
			end
		end
	end

	if needCheck then
		local nextStep = CheckOutGroupsStep.New();
		self.queen:Insert(self,nextStep);
	else
		self.queen:StepNext();
	end
end

BlockAutoDecreaseStep = class("BlockAutoDecreaseStep", BattleStep);

function BlockAutoDecreaseStep:ctor()
	BattleStep.ctor(self);
end

function BlockAutoDecreaseStep:OnStepInto()
	local needReset = false;
	for _,v in ipairs(Battle.instance.sortedGrids) do
		if v.block and v.block:AutoDecrease() then
			needReset = true;
		end
	end

	if needReset then
		local nextNode = ResetGridsStep.New();
		self.queen:Insert(self, nextNode);
	end

	self.queen:StepNext();
end

