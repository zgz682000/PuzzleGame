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
