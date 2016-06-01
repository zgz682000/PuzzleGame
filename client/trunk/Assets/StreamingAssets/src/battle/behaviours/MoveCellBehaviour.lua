

MoveCellBehaviour = class("MoveCellBehaviour", LuaBehaviour)

local kDropGravity = 40;
local kDropInitalDict = 0.5

function MoveCellBehaviour:Start()
	local elementImg = self.gameObject:GetComponent("Image");
	if elementImg then
		if self.sprites then
			elementImg.sprite = self.sprites["cell_" .. self.cell:GetColor()];
		end
		elementImg:SetNativeSize();
	end
end

function MoveCellBehaviour:OnClick(eventData)
	if not BattleControl.enabled then
		return;
	end
	if not self.target or not self.target.OnMoveCellClicked then
		return;
	end
	self.target:OnMoveCellClicked(self);
end

function MoveCellBehaviour:OnBeginDrag(eventData)
	if not BattleControl.enabled then
		return;
	end
	if not self.target or not self.target.OnMoveCellDragBegan then
		return;
	end
	self.target:OnMoveCellDragBegan(self);
end

function MoveCellBehaviour:OnDrag(eventData)
	if not BattleControl.enabled then
		return;
	end
	if not self.target or not self.target.OnMoveCellDraging then
		return;
	end
	self.target:OnMoveCellDraging(self, eventData);
end

function MoveCellBehaviour:OnEndDrag(eventData)
	if not BattleControl.enabled then
		return;
	end
	if not self.target or not self.target.OnMoveCellEnded then
		return;
	end
	self.target:OnMoveCellDragEnded(self);
end

function MoveCellBehaviour:RunExchangeAction(toPosition, callback)
	local time = 0.3;
	iTween.MoveTo(self.gameObject, createITweenHash(self.gameObject, callback, "position", Vector3.New(toPosition.x, toPosition.y, 0), "time", time, "islocal", true));
end

function MoveCellBehaviour:RunGenerateAction(callback)
	self.gameObject.transform.localScale = Vector3.New(0.5, 0.5, 1);
	local time = 0.1;
	iTween.ScaleTo(self.gameObject, createITweenHash(self.gameObject,  callback, "scale", Vector3.New(1, 1, 1), "time", time, "islocal", true, "easetype", "linear"));
end

function MoveCellBehaviour:RunRemoveAction(callback)
	local time = 0.2;
	iTween.ScaleTo(self.gameObject, createITweenHash(self.gameObject, function ()
		iTween.ScaleTo(self.gameObject, createITweenHash(self.gameObject, function ()
			-- Object.Destroy(self.gameObject);
			self.gameObject:SetActive(false);
			self.target:AddDestoryCell(self);
			if callback then
				callback();
			end
		end, "scale", Vector3.New(0.8, 0.8, 0), "time", time, "islocal", true, "easetype", "linear"));
	end , "scale", Vector3.New(1.1, 1.1, 0), "time", time, "islocal", true, "easetype", "linear"));
end

function MoveCellBehaviour:RunDropBounceAction()
	local bounceDistance = self.cell.dropDistance * 5;
	iTween.MoveTo(self.gameObject, createITweenHash(self.gameObject, function()
		iTween.MoveTo(self.gameObject, createITweenHash(self.gameObject, nil, "position", Vector3.New(self.gameObject.transform.localPosition.x, self.gameObject.transform.localPosition.y - bounceDistance, 0), "time", 0.2, "islocal", true, "easetype", "easeInBounce"));
	end , "position", Vector3.New(self.gameObject.transform.localPosition.x, self.gameObject.transform.localPosition.y + bounceDistance, 0), "time", 0.2, "islocal", true, "easetype", "easeOutQuad"));
end

function MoveCellBehaviour:RunGateWayDropAction(toPosition, callback)
	iTween.ScaleTo(self.gameObject, createITweenHash(self.gameObject,  function ()
		self.gameObject.transform.localPosition = toPosition;
		iTween.ScaleTo(self.gameObject, createITweenHash(self.gameObject,  callback, "scale", Vector3.New(1, 1, 1), "time", 0.1, "islocal", true, "easetype", "linear"));
	end, "scale", Vector3.New(0.5, 0.5, 1), "time", 0.1, "islocal", true, "easetype", "linear"));
end

function MoveCellBehaviour:RunDropAction(toPosition, callback)
	local dropDistance = self.cell.dropDistance;
	if dropDistance == 0 then
		dropDistance = kDropInitalDict;
	end
	local time = 0.1;
	iTween.MoveTo(self.gameObject, createITweenHash(self.gameObject, callback, "position", Vector3.New(toPosition.x, toPosition.y, 0), "time", time, "islocal", true, "easetype", "linear"));
end

function MoveCellBehaviour:RunAlertAction()
	local time = 0.2;
	iTween.ScaleTo(self.gameObject, createITweenHash(self.gameObject, function ()
		iTween.ScaleTo(self.gameObject, createITweenHash(self.gameObject, function ()
			iTween.ScaleTo(self.gameObject, createITweenHash(self.gameObject, function ()
				iTween.ScaleTo(self.gameObject, createITweenHash(self.gameObject, function ()
					iTween.ScaleTo(self.gameObject, createITweenHash(self.gameObject, nil, "scale", Vector3.New(1, 1, 0), "time", time, "islocal", true, "easetype", "linear"));
				end, "scale", Vector3.New(0.8, 0.8, 0), "time", time, "islocal", true, "easetype", "linear"));
			end, "scale", Vector3.New(1.1, 1.1, 0), "time", time, "islocal", true, "easetype", "linear"));
		end, "scale", Vector3.New(0.8, 0.8, 0), "time", time, "islocal", true, "easetype", "linear"));
	end, "scale", Vector3.New(1.1, 1.1, 0), "time", time, "islocal", true, "easetype", "linear"));
end
