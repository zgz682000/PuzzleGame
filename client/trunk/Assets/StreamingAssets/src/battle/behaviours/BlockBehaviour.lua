BlockBehaviour = class("BlockBehaviour", LuaBehaviour)


function BlockBehaviour:Start()
	local elementImg = self.gameObject:GetComponent("Image");
	if elementImg then
		if self.sprites then
			local blockMeta = ElementMeta[self.block.metaId];
			elementImg.sprite = self.sprites[blockMeta.name];
		end
		elementImg:SetNativeSize();
	end
end