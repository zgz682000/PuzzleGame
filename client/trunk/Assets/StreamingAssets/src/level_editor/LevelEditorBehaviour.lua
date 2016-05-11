
require "battle.model.HexagonGrid"
require "battle.behaviours.BattleBehaviour"

LevelEditorBehaviour = class("LevelEditorBehaviour", LuaBehaviour);

function LevelEditorBehaviour.CreateElementByMetaId(metaId, parent, scale)
	local name = ElementMeta[metaId].name;
	return LevelEditorBehaviour.CreateElementByName("LevelEditor/editor_" .. name, parent, scale);
end


function LevelEditorBehaviour.CreateElementByName(name, parent, scale)
	print(name);
	local element = CreatePrefab("Prefab/Grid", Vector3.zero, Vector3.one * scale , parent);
	local elementSpr = element:GetComponent("UnityEngine.UI.Image");
	local elementTex = ResourcesLoad(name);
	local elementSp = UnityEngine.Sprite.Create(elementTex, UnityEngine.Rect.New(0,0,elementTex.width, elementTex.height),Vector2.New(0.5,0.5));
	elementSpr.sprite = elementSp;
	elementSpr:SetNativeSize();
	return element;
end

function LevelEditorBehaviour:Start()
	self.currentLevelMeta = {};
	self.mapPanel = self.gameObject.transform:Find("MapPanel");
	self:OnCellButtonClicked();
	for j = 0, 8 do
		local initY = 0;
		if j % 2 == 0 then
			initY = 0
		else
			initY = 0.866 / 2
		end
		for i = 0, 7 do
			y = initY + i * 0.866;
			x = j * 0.75;
			local pos = Vector3.New(x * BattleBehaviour.kGridUnit - 1194, y * BattleBehaviour.kGridUnit - 440, -1);
			local grid = LevelEditorBehaviour.CreateElementByName("LevelEditor/editor_grid_back", self.mapPanel, 1);
			grid.transform.localPosition = pos;
			grid.name = tostring(HexagonGrid.GetKeyFromPosition({x = x, y = y}));
		end
	end 

end


function LevelEditorBehaviour:OnGoButtonClicked()
	local levelId = self.levelIdTextField:GetComponent("UnityEngine.UI.InputField").text;
	if levelId and levelId ~= "" then
		if LevelMeta[tonumber(levelId)] then
			self.currentLevelMeta = LevelMeta[tonumber(levelId)];
		end
	end
	if self.currentLevelMeta.unlockStar then
		self.levelUnlockTextField:GetComponent("UnityEngine.UI.InputField").text = tostring(self.currentLevelMeta.unlockStar);
	end

	if self.currentLevelMeta.starScore then
		local starScoreText = PZClass.Serialize(self.currentLevelMeta.starScore);
		self.levelStarScoreTextField:GetComponent("UnityEngine.UI.InputField").text = starScoreText;
	end

	if self.currentLevelMeta.levelTarget then
		local levelTargetText = PZClass.Serialize(self.currentLevelMeta.levelTarget);
		self.levelTargetTextField:GetComponent("UnityEngine.UI.InputField").text = levelTargetText;
	end

	if self.currentLevelMeta.levelLimit then
		local levelLimitText = PZClass.Serialize(self.currentLevelMeta.levelLimit);
		self.levelLimitTextField:GetComponent("UnityEngine.UI.InputField").text = levelLimitText;
	end

	if self.currentLevelMeta.refreshRate then
		local refreshRateText = PZClass.Serialize(self.currentLevelMeta.refreshRate);
		self.levelRefreshRateTextField:GetComponent("UnityEngine.UI.InputField").text = refreshRateText;
	end

	if not self.currentLevelMeta.map then
		self.currentLevelMeta.map = {};
	end

	for j = 0, 8 do
		local initY = 0;
		if j % 2 == 0 then
			initY = 0
		else
			initY = 0.866 / 2
		end
		for i = 0, 7 do
			y = initY + i * 0.866;
			x = j * 0.75;
			local key = HexagonGrid.GetKeyFromPosition({x = x, y = y})
			local name = tostring(key);
			local grid = self.mapPanel.transform:Find(name);
			for k=0,grid.childCount - 1 do
				local element = grid:GetChild(k);
				Object.Destroy(element.gameObject);
			end
		end
	end 

	for k,v in pairs(self.currentLevelMeta.map) do
		local grid = self.mapPanel.transform:Find(tostring(k));
		if v.grid then
			local e = self:CreateNewElementOnGrid(v.grid, grid);
		end
		if v.cell then
			local e = self:CreateNewElementOnGrid(v.cell, grid);
			e.transform.localPosition = Vector3.New(0,0,-1);
		end

		if v.block then
			local e = self:CreateNewElementOnGrid(v.block, grid);
			e.transform.localPosition = Vector3.New(0,0,-2);
		end
	end
end

function LevelEditorBehaviour:OnPlayButtonClicked()
	if self.mapPanel.gameObject.activeSelf then
		local levelId = self.levelIdTextField:GetComponent("UnityEngine.UI.InputField").text;
		if levelId and levelId ~= "" then
			if self.currentSelectElement then
				Object.Destroy(self.currentSelectElement);
				self.currentSelectElement = nil;
			end
			self:OnSaveButtonClicked();
			self.mapPanel.gameObject:SetActive(false);
			local battleBehaviour = GameObject.Find("BattleRoot"):GetComponent("LuaComponent").luaBehaviour;
			battleBehaviour:InitWithLevelMetaId(tonumber(levelId));
		end
	else
		local battleRoot = GameObject.Find("BattleRoot");
		Object.Destroy(battleRoot);
		self.mapPanel.gameObject:SetActive(true);
		local newBattleRoot = CreatePrefab("Prefab/BattleRoot", Vector3.New(-7.4, 0, 0));
		newBattleRoot.name = "BattleRoot";
	end
end

function LevelEditorBehaviour:OnCancelButtonClicked()
	if not self.mapPanel.gameObject.activeSelf then
		return;
	end
	package.loaded["data.LevelMeta"] = nil;
	require("data.LevelMeta");
	self:OnGoButtonClicked()
end

function LevelEditorBehaviour:OnSaveButtonClicked()
	if not self.mapPanel.gameObject.activeSelf then
		return;
	end
	local levelId = self.levelIdTextField:GetComponent("UnityEngine.UI.InputField").text;
	if not levelId or levelId == "" then
		return;
	end

	LevelMeta[tonumber(levelId)] = self.currentLevelMeta;

	self.currentLevelMeta.metaId = tonumber(levelId);

	local levelUnlockText = self.levelUnlockTextField:GetComponent("UnityEngine.UI.InputField").text;
	if levelUnlockText and levelUnlockText ~= "" then
		self.currentLevelMeta.unlockStar = tonumber(levelUnlockText);
	end

	local starScoreText = self.levelStarScoreTextField:GetComponent("UnityEngine.UI.InputField").text;
	if starScoreText and starScoreText ~= "" then
		self.currentLevelMeta.starScore = assert(loadstring("return " .. starScoreText)());
	end

	local levelTargetText = self.levelTargetTextField:GetComponent("UnityEngine.UI.InputField").text;
	if levelTargetText and levelTargetText ~= "" then
		self.currentLevelMeta.levelTarget = assert(loadstring("return " .. levelTargetText)());
	end

	local levelLimitText = self.levelLimitTextField:GetComponent("UnityEngine.UI.InputField").text;
	if levelLimitText and levelLimitText ~= "" then
		self.currentLevelMeta.levelLimit = assert(loadstring("return " .. levelLimitText)());
	end

	local refreshRateText = self.levelRefreshRateTextField:GetComponent("UnityEngine.UI.InputField").text;
	if refreshRateText and refreshRateText ~= "" then
		self.currentLevelMeta.refreshRate = assert(loadstring("return " .. refreshRateText)());
	end


	self.currentLevelMeta.map = {};
	for j = 0, 8 do
		local initY = 0;
		if j % 2 == 0 then
			initY = 0
		else
			initY = 0.866 / 2
		end
		for i = 0, 7 do
			y = initY + i * 0.866;
			x = j * 0.75;
			local key = HexagonGrid.GetKeyFromPosition({x = x, y = y})
			local name = tostring(key);
			local grid = self.mapPanel.transform:Find(name);
			if grid.childCount ~= 0 then
				local gridMeta = {};
				for k=0,grid.childCount - 1 do
					local element = grid:GetChild(k);
					local elementName = element.gameObject.name;
					local elementMeta = ElementMeta[tonumber(elementName)];
					gridMeta[elementMeta.type] = tonumber(elementName);
				end
				self.currentLevelMeta.map[key] = gridMeta;
			end
		end
	end 

	local metaString = "LevelMeta = " .. PZClass.Serialize(LevelMeta, true);
	local fp = io.open(Application.streamingAssetsPath .. "/src/data/LevelMeta.lua", "w");
	fp:write(metaString);
	fp:close();

	package.loaded["data.LevelMeta"] = nil;
	require("data.LevelMeta");
	self:OnGoButtonClicked()
end

function LevelEditorBehaviour:CleanElements()
	for i=0,31 do
		local panel = self.addElementPanel.transform:Find("Panel" .. tostring(i));
		for j=0,panel.childCount - 1 do
			local child = panel:GetChild(j).gameObject;
			Object.Destroy(child);
		end
	end
end

function LevelEditorBehaviour:RefreshElementButtons(typeName)
	self:CleanElements();
	self.elementMetaIds = {};
	for k,v in pairs(ElementMeta) do
		if v.type == typeName then
			local panel = self.addElementPanel.transform:Find("Panel" .. tostring(#self.elementMetaIds))
			local element = LevelEditorBehaviour.CreateElementByMetaId(k, panel, 1);
			element.transform.localPosition = Vector3.New(0,0,-1);
			table.insert(self.elementMetaIds, k);
		end
	end
end


function LevelEditorBehaviour:OnElementButtonClicked(elementButton)
	if not self.mapPanel.gameObject.activeSelf then
		return;
	end
	if self.currentSelectElement then
		Object.Destroy(self.currentSelectElement);
		self.currentSelectElement = nil;
	end
	local elementButtonIndex = tonumber(string.sub(elementButton.name, 6, 7)) + 1;
	local newSelectElementMetaId = self.elementMetaIds[elementButtonIndex];
	if not self.currentSelectElementMetaId or newSelectElementMetaId ~= self.currentSelectElementMetaId then
		self.currentSelectElementMetaId = newSelectElementMetaId;
		self.currentSelectElement = LevelEditorBehaviour.CreateElementByMetaId(self.currentSelectElementMetaId, self.gameObject.transform, 1);
	else
		self.currentSelectElementMetaId = nil;
	end
end


function LevelEditorBehaviour:OnGridButtonClicked()
	if not self.mapPanel.gameObject.activeSelf then
		return;
	end
	self:RefreshElementButtons("grid");
end

function LevelEditorBehaviour:OnCellButtonClicked()
	if not self.mapPanel.gameObject.activeSelf then
		return;
	end
	self:RefreshElementButtons("cell");
end

function LevelEditorBehaviour:OnBlockButtonClicked()
	if not self.mapPanel.gameObject.activeSelf then
		return;
	end
	self:RefreshElementButtons("block");
end

function LevelEditorBehaviour:OnGateButtonClicked()
	if not self.mapPanel.gameObject.activeSelf then
		return;
	end
end

function LevelEditorBehaviour:Update()
	if not self.mapPanel.gameObject.activeSelf then
		return;
	end

	if self.currentSelectElement then
		
		local currentGrid = nil;

		local pos = Camera.main:ScreenToWorldPoint(Input.mousePosition);
		local newPos = Vector3.New(pos.x, pos.y, -1);
		self.currentSelectElement.transform.position = newPos;
		for j = 0, 8 do
			local initY = 0;
			if j % 2 == 0 then
				initY = 0
			else
				initY = 0.866 / 2
			end
			for i = 0, 7 do
				y = initY + i * 0.866;
				x = j * 0.75;
				local key = HexagonGrid.GetKeyFromPosition({x = x, y = y})
				local name = tostring(key);
				local child = self.mapPanel.transform:Find(name);
				local pos1 = Vector3.New(child.transform.localPosition.x, child.transform.localPosition.y, 0);
				local pos2 = Vector3.New(self.currentSelectElement.transform.localPosition.x, self.currentSelectElement.transform.localPosition.y, 0);
				local dist = Vector3.Distance(pos1, pos2);
				if dist <= 65 then
					self.currentSelectElement.transform.localPosition = child.transform.localPosition;
					currentGrid = child;			
				end
			end
		end
		if currentGrid and Input.GetMouseButtonDown(0) then
			local elementMeta = ElementMeta[self.currentSelectElementMetaId]
			local shouldCreateNewElement = true;
			if currentGrid.childCount ~= 0 then
				for i=0,currentGrid.childCount - 1 do
					local child = currentGrid:GetChild(i);
					local childName = child.gameObject.name;
					local childMeta = ElementMeta[tonumber(childName)];
					if childMeta.type == elementMeta.type then
						Object.Destroy(child.gameObject);  
						if tonumber(childName) == self.currentSelectElementMetaId then
							shouldCreateNewElement = false;
						end
					end
				end
			end
			if shouldCreateNewElement then
				self:CreateNewElementOnGrid(self.currentSelectElementMetaId, currentGrid);
			end
		end
	end
end


function LevelEditorBehaviour:CreateNewElementOnGrid(metaId, grid)
	local elementMeta = ElementMeta[metaId];
	if elementMeta.type ~= "grid" then
		local gridExist = false;
		for i=0,grid.childCount - 1 do
			local child = grid:GetChild(i);
			local childName = child.gameObject.name;
			local childMeta = ElementMeta[tonumber(childName)];
			if childMeta.type == "grid" then
				gridExist = true;
			end
		end
		if not gridExist then
			return;
		end
	end
	local element = LevelEditorBehaviour.CreateElementByMetaId(metaId, grid, 1);
	element.name = tostring(metaId);
	return element;
end




