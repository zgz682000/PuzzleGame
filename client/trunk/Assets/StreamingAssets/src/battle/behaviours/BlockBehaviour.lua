BlockBehaviour = class("BlockBehaviour", LuaBehaviour)


function BlockBehaviour:Start()
	self:ResetSprite();
end


function BlockBehaviour:RunRemoveAction()
	GameObject.Destroy(self.gameObject);
end


function BlockBehaviour:RunConvertAction()
	self:ResetSprite();
end


function BlockBehaviour:ResetSprite()
	local elementImg = self.gameObject:GetComponent("Image");
	if elementImg then
		if self.sprites then
			local blockMeta = ElementMeta[self.block.metaId];
			elementImg.sprite = self.sprites[blockMeta.name];
		end
		elementImg:SetNativeSize();
	end
end


function BlockBehaviour:RunMoveAction(toPosition, callback)
	local fromPosition = self.gameObject.transform.localPosition;
	local rotation = -90 + math.atan2(toPosition.y - fromPosition.y , toPosition.x - fromPosition.x) * math.rad2Deg;
	iTween.RotateTo(self.gameObject, createITweenHash(self.gameObject, function()
		iTween.MoveTo(self.gameObject, createITweenHash(self.gameObject, callback, "position", Vector3.New(toPosition.x, toPosition.y, 0), "time", 0.4, "islocal", true, "easetype", "linear"));
	end , "rotation", Vector3.New(0, 0, rotation), "time", 0.2, "islocal", true));
end