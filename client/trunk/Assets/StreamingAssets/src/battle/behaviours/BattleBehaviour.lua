require "battle.model.Battle"
require "base.LuaBehaviour"
require "battle.events.BattleEvents"
require "battle.events.BattleControl"

BattleBehaviour = class("BattleBehaviour", LuaBehaviour)

BattleBehaviour.kGridUnit = 151.5;

function BattleBehaviour:Start()
	self.cellBehaviours = {};
	self.destroyCells = {};

	self.blockBehaviours = {};

	WaitingControlStepIntoEvent:AddHandler(BattleBehaviour.WaitingControlStepIntoHandler, self);
	CellExchangedEvent:AddHandler(BattleBehaviour.CellExchangedHandler, self);
	CellExchangeCanceledEvent:AddHandler(BattleBehaviour.CellExchangeCanceledHandler, self);
	CellRemovedEvent:AddHandler(BattleBehaviour.CellRemovedHandler, self);
	CellDropEvent:AddHandler(BattleBehaviour.CellDropHandler, self);
	CellGeneratedEvent:AddHandler(BattleBehaviour.CellGeneratedHandler, self);
	CellRerangeEvent:AddHandler(BattleBehaviour.CellRerangeHandler, self);
	CellAlertEvent:AddHandler(BattleBehaviour.CellAlertHandler, self);
	BombCellGenerateEvent:AddHandler(BattleBehaviour.BombCellGenerateHandler, self);
	CellConventEvent:AddHandler(BattleBehaviour.CellConventHandler, self);
	BlockDecreaseEvent:AddHandler(BattleBehaviour.BlockDecreaseHandler, self);
	BlockGrowEvent:AddHandler(BattleBehaviour.BlockGrowHandler, self);
	BlockMoveEvent:AddHandler(BattleBehaviour.BlockMoveHandler, self);

	if UnityEngine.SceneManagement.SceneManager.GetActiveScene().name == "BattleScene" then
		if self.isReplay == "true" then
			local levelId = ReplayManager.LoadReplay(self.replayName);
			self:InitWithLevelMetaId(levelId, true);
		else
			self:InitWithLevelMetaId(90001);
		end
	end
end

function BattleBehaviour:AddDestoryCell(cell)
	table.insert(self.destroyCells, cell);
end

function BattleBehaviour:WaitingControlStepIntoHandler(e)
	for i,v in ipairs(self.destroyCells) do
		self.cellBehaviours[v.cell.elementId] = nil;
		Object.Destroy(v.gameObject);
	end
end

function BattleBehaviour:OnDestroy()

	CellExchangedEvent:RemoveHandler(BattleBehaviour.CellExchangedHandler, self);
	CellExchangeCanceledEvent:RemoveHandler(BattleBehaviour.CellExchangeCanceledHandler, self);
	CellRemovedEvent:RemoveHandler(BattleBehaviour.CellRemovedHandler, self);
	CellDropEvent:RemoveHandler(BattleBehaviour.CellDropHandler, self);
	CellGeneratedEvent:RemoveHandler(BattleBehaviour.CellGeneratedHandler, self);
	CellRerangeEvent:RemoveHandler(BattleBehaviour.CellRerangeHandler, self);
	CellAlertEvent:RemoveHandler(BattleBehaviour.CellAlertHandler, self);
	BombCellGenerateEvent:RemoveHandler(BattleBehaviour.BombCellGenerateHandler, self);
	CellConventEvent:RemoveHandler(BattleBehaviour.CellConventHandler, self);
	BlockDecreaseEvent:RemoveHandler(BattleBehaviour.BlockDecreaseHandler, self);
	BlockGrowEvent:RemoveHandler(BattleBehaviour.BlockGrowHandler, self);
	BlockMoveEvent:RemoveHandler(BattleBehaviour.BlockMoveHandler, self);

	if Battle.instance then
		Battle.instance:Clean();
		Battle.instance = nil;
	end

	ReplayManager.SaveReplay();
end

function BattleBehaviour:BlockMoveHandler(e)
	local blockBehaviour = self.blockBehaviours[e.block.elementId];
	local rp = BattleBehaviour.GetGridRealPosition(e.block.position);
	blockBehaviour:RunMoveAction(rp, function ()
		e:DoAfterHandle();
	end);
end

function BattleBehaviour:BlockGrowHandler(e)
	local blockBehaviour = self:CreateBlock(e.block, e.block.position);
	if e.removeCell then
		local removeCellBehaviour = self.cellBehaviours[e.removeCell.elementId];
		removeCellBehaviour.gameObject:SetActive(false);
		self:AddDestoryCell(removeCellBehaviour);
	end
end

function BattleBehaviour:BlockDecreaseHandler(e)
	local blockBehaviour = self.blockBehaviours[e.block.elementId];
	if e.remove then
		blockBehaviour:RunRemoveAction();
	else
		blockBehaviour:RunConvertAction();
	end
end

function BattleBehaviour:CellConventHandler(e)
	local preCellBehaviour = self.cellBehaviours[e.preCell.elementId]; 
	preCellBehaviour.gameObject:SetActive(false);
	self:AddDestoryCell(preCellBehaviour);
	local lp = e.conventCell.position;
	local _, cellBehaviour = self:CreateCell(e.conventCell, lp);

	Timer.New(function()
		e.node.queen:StepNext(true);
	end, 1):Start();
end

function BattleBehaviour:CellGeneratedHandler(e)
	local lp = e.grid.position;
	local _, cellBehaviour = self:CreateCell(e.cell, lp);
	cellBehaviour:RunGenerateAction();
	e.node.queen:StepNext();
end

function BattleBehaviour:CellDropHandler(e)
	local cellBehaviour = self.cellBehaviours[e.cell.elementId];
	local rp = BattleBehaviour.GetGridRealPosition(e.toGrid.position);

	if not e.dropFromGateWay then
		cellBehaviour:RunDropAction(rp, function()
			if not e.node.nextNode then
				cellBehaviour:RunDropBounceAction();
			end
			e.node.queen:StepNext(true);
		end);
	else
		cellBehaviour:RunGateWayDropAction(rp, function ()
			if not e.node.nextNode then
				cellBehaviour:RunDropBounceAction();
			end
			e.node.queen:StepNext(true);
		end)
	end
end


function BattleBehaviour:CellRemovedHandler(e)
	local cellBehaviour = self.cellBehaviours[e.cell.elementId];
	cellBehaviour:RunRemoveAction(function ()
		e.node.queen:StepNext(true);
	end);
end

function BattleBehaviour:CellExchangedHandler(e)
	local rp = BattleBehaviour.GetGridRealPosition(e.toGrid.position);
	local cellBehaviour = self.cellBehaviours[e.cell.elementId];
	cellBehaviour:RunExchangeAction(rp, function ()
		e.node.queen:StepNext(true);
	end);
end

function BattleBehaviour:CellExchangeCanceledHandler(e)
	local rp = BattleBehaviour.GetGridRealPosition(e.toGrid.position);
	local cellBehaviour = self.cellBehaviours[e.cell.elementId];
	cellBehaviour:RunExchangeAction(rp, function ()
		e.node.queen:StepNext(true);
	end);
end

function BattleBehaviour:CellRerangeHandler(e)
	local rp = BattleBehaviour.GetGridRealPosition(e.cell.position);
	local cellBehaviour = self.cellBehaviours[e.cell.elementId];
	cellBehaviour:RunExchangeAction(rp, function ()
		e.node.queen:StepNext(true);
	end);
end

function BattleBehaviour:CellAlertHandler(e)
	local cellBehaviour = self.cellBehaviours[e.cell.elementId];
	cellBehaviour:RunAlertAction();
end

function BattleBehaviour:BombCellGenerateHandler(e)
	local lp = e.bombCell.position;
	local _, cellBehaviour = self:CreateCell(e.bombCell, lp);
	cellBehaviour:RunGenerateAction();
	e.node.queen:StepNext();
end


function BattleBehaviour:InitWithLevelMetaId(levelMetaId, isReplay)
	randomseed = randomseed or 1;

	if not isReplay then
		ReplayManager.InitReplay(levelMetaId);
	end
	Battle.instance = Battle.New();
	Battle.instance:InitWithLevelMetaId(levelMetaId);
	self:InitMap();

	if isReplay then
		ReplayManager.PlayRecord();
	end
end

function BattleBehaviour.GetGridRealPosition(lp)
	return {x = lp.x * BattleBehaviour.kGridUnit - 453, y = lp.y * BattleBehaviour.kGridUnit - 438}
end

function BattleBehaviour:InitMap()
	local mapPanel = self.gameObject.transform:Find("MapPanel");
	
	for _,v in ipairs(Battle.instance.sortedGrids) do
		local k = v:GetKey();
		local lp = HexagonGrid.GetPositionFromKey(k);
		local rp = BattleBehaviour.GetGridRealPosition(lp);
		local gridElement = BattleBehaviour.CreateElementByMetaId(v.metaId, mapPanel, 1);
		gridElement.name = tostring(lp.x) .. ", " .. tostring(lp.y);
		gridElement.transform.localPosition = Vector3.New(rp.x, rp.y, 0);
		if v.cell then
			self:CreateCell(v.cell, lp);
		end

		if v.block then
			self:CreateBlock(v.block, lp);
		end

		if v.gate then
			self:CreateGate(v.gate, lp);
		end
	end
end

function BattleBehaviour:CreateGate(gate, logicPosition)
	local gatePanel = self.gameObject.transform:Find("GatePanel");
	local realPosition = BattleBehaviour.GetGridRealPosition(logicPosition);
	local gateElement = BattleBehaviour.CreateElementByMetaId(gate.metaId, gatePanel, 1);
	gateElement.name = "gate_" .. tostring(gate.elementId);
	gateElement.transform.localPosition = Vector3.New(realPosition.x, realPosition.y, 0);
	return gateElement;
end

function BattleBehaviour:CreateBlock(block, logicPosition)
	local blockPanel = self.gameObject.transform:Find("BlockPanel_2");
	if block:GetRenderOrder() then
		blockPanel = self.gameObject.transform:Find("BlockPanel_" .. block:GetRenderOrder());
	end
	local realPosition = BattleBehaviour.GetGridRealPosition(logicPosition);
	local blockElement = BattleBehaviour.CreateElementByMetaId(block.metaId, blockPanel, 1);
	blockElement.name = "block_" .. tostring(block.elementId);
	blockElement.transform.localPosition = Vector3.New(realPosition.x, realPosition.y, 0);
	local blockBehaviour = blockElement:GetComponent("LuaComponent").luaBehaviour;
	blockBehaviour.target = self;
	blockBehaviour.block = block;
	self.blockBehaviours[block.elementId] = blockBehaviour;
	return blockElement, blockBehaviour;
end

function BattleBehaviour:CreateCell(cell, logicPosition)
	local cellPanel = self.gameObject.transform:Find("CellPanel");
	local realPosition = BattleBehaviour.GetGridRealPosition(logicPosition);
	local cellElement = BattleBehaviour.CreateElementByMetaId(cell.metaId, cellPanel, 1);
	cellElement.name = "cell_" .. tostring(cell.elementId);
	cellElement.transform.localPosition = Vector3.New(realPosition.x, realPosition.y, 0);
	local cellBehaviour = cellElement:GetComponent("LuaComponent").luaBehaviour;
	cellBehaviour.target = self;
	cellBehaviour.cell = cell;
	self.cellBehaviours[cell.elementId] = cellBehaviour;
	return cellElement, cellBehaviour;
end

function BattleBehaviour.CreateElementByMetaId(metaId, parent, scale)
	local meta = ElementMeta[metaId];
	local element = nil;
	if meta.type == "grid" then
		element = CreatePrefab("Prefab/Grid", Vector3.zero, Vector3.one * scale , parent);
	elseif meta.type == "cell" then
		if string.sub(meta.name, -6) == "normal" then
			element = CreatePrefab("Prefab/MoveCell", Vector3.zero, Vector3.one * scale , parent);
		elseif string.sub(meta.name, -5) == "vBomb" or string.sub(meta.name, -5) == "lBomb" or string.sub(meta.name, -5) == "rBomb" then
			element = CreatePrefab("Prefab/BombLine", Vector3.zero, Vector3.one * scale , parent);
		elseif string.sub(meta.name, -5) == "aBomb" then
			element = CreatePrefab("Prefab/BombArea", Vector3.zero, Vector3.one * scale , parent);
		elseif meta.name == "cell_mix" then
			element = CreatePrefab("Prefab/BombColor", Vector3.zero, Vector3.one * scale , parent);
		end
	elseif meta.type == "block" then
		element = CreatePrefab("Prefab/Block", Vector3.zero, Vector3.one * scale , parent);
	elseif meta.type == "gate" then
		if meta.name == "gate_enter" then
			element = CreatePrefab("Prefab/GateEnter", Vector3.zero, Vector3.one * scale , parent);
		elseif meta.name == "gate_exit" then
			element = CreatePrefab("Prefab/GateExit", Vector3.zero, Vector3.one * scale , parent);
		end
	end
	return element;
end


function BattleBehaviour:OnMoveCellDragBegan(cellBehaviour)
	if ReplayManager.mode == "playing" then
		return;
	end

	if not BattleControl.enabled then
		return;
	end
	self.exchangeControl = BattleControlExchange.New();
	self.exchangeControl.grid = cellBehaviour.cell:GetGrid(); 
end

function BattleBehaviour:OnMoveCellDragEnded(cellBehaviour)
	if ReplayManager.mode == "playing" then
		return;
	end
	if not BattleControl.enabled then
		return;
	end
	self.exchangeControl = nil;
end

function BattleBehaviour:OnMoveCellDraging(cellBehaviour, eventData)
	if ReplayManager.mode == "playing" then
		return;
	end
	if not BattleControl.enabled then
		return;
	end

	if not self.exchangeControl then
		return;
	end

	local cellGrid = cellBehaviour.cell:GetGrid();
	if cellGrid.block and not cellGrid.block:GetCellMoveable() then
		return;
	end
	local worldPosition = Camera.main:ScreenToWorldPoint(eventData.position);
	local localPosition = cellBehaviour.gameObject.transform.parent:InverseTransformPoint(worldPosition);
	localPosition:Set(localPosition.x, localPosition.y, 0);
	for k,v in pairs(HexagonGrid.Direction) do
		local otherGrid = cellGrid:GetGridByDirection(v);
		if otherGrid and otherGrid.cell and (not otherGrid.block or otherGrid.block:GetCellMoveable()) then
			local otherCellBehaviour = self.cellBehaviours[otherGrid.cell.elementId];
			if Vector3.Distance(otherCellBehaviour.gameObject.transform.localPosition, localPosition) <= BattleBehaviour.kGridUnit * 0.4 then
				self.exchangeControl.direction = v;
				self.exchangeControl:Happen();
				self.exchangeControl = nil;
				return;
			end
		end
	end

	print("xxx " .. cellBehaviour.cell.elementId);
end

function BattleBehaviour:OnMoveCellClicked(cellBehaviour)
	if ReplayManager.mode == "playing" then
		return;
	end
	if not BattleControl.enabled then
		return;
	end
	local cellGrid = cellBehaviour.cell:GetGrid();
	if cellGrid.block and not cellGrid.block:GetCellMoveable() then
		return;
	end
	if not self.exchangeControl then
		self.exchangeControl = BattleControlExchange.New();
		self.exchangeControl.grid = cellGrid;
	else
		local grid = cellGrid;
		local direction = self.exchangeControl.grid:GetDirectionOfGrid(grid);
		if direction then
			self.exchangeControl.direction = direction;
			self.exchangeControl:Happen();
			self.exchangeControl = nil;
		else
			self.exchangeControl = BattleControlExchange.New();
			self.exchangeControl.grid = grid;
		end
	end
end
