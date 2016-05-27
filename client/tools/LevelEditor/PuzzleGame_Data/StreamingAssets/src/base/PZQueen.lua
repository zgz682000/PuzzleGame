
PZQueen = class("PZQueen", PZClass);

function PZQueen:ctor()
	self.firstNode = nil;
	self.lastNode = nil;
	self.currentNode = nil;
	self.isPaused = false;
end

function PZQueen:Launch(firstNode)
	self:OnLaunch();
	firstNode.queen = self;
	self.firstNode = firstNode;
	self.lastNode = firstNode;
	self.currentNode = firstNode;
	if not self.isPaused then
		self.currentNode:OnStepInto();
	end
end


function PZQueen:Pause()
	self.isPaused = true;
end

function PZQueen:Resume()
	self.isPaused = false;
	if self.currentNode then
		self.currentNode:OnStepInto();
	end
end

function PZQueen:StepNext(immediate)
	if not self.currentNode then
		return;
	end


	------------------------------------------------------------
	--2016年3月18 0：32-------------------------------------------
	--这个地方改成先进入下一帧再判断链表是否结束，以解决有水果半路卡主的问题
	------------------------------------------------------------
	if immediate then
		if self.currentNode.nextNode then
			local nextNode = self.currentNode.nextNode;
			nextNode.preNode = self.currentNode;
			self.currentNode:OnStepOut();
			self.currentNode:Clean();
			self.currentNode = nextNode;
			if not self.isPaused then
				self.currentNode:OnStepInto();
			end
		else
			self.currentNode:OnStepOut();
			self:OnFinished();
			self:Clean();
		end
	else
		callNextFrame(function ()
			if self.currentNode.nextNode then
				local nextNode = self.currentNode.nextNode;
				nextNode.preNode = self.currentNode;
				self.currentNode:OnStepOut();
				self.currentNode:Clean();
				self.currentNode = nextNode;
				if not self.isPaused then
					self.currentNode:OnStepInto();
				end
			else
				self.currentNode:OnStepOut();
				self:OnFinished();
				self:Clean();
			end
		end);
	end
	-- if self.currentNode.nextNode then
	-- 	local nextNode = self.currentNode.nextNode;
	-- 	nextNode.preNode = self.currentNode;
	-- 	if immediate then
	-- 		self.currentNode:OnStepOut();
	-- 		self.currentNode:Clean();
	-- 		self.currentNode = nextNode;
	-- 		if not self.isPaused then
	-- 			self.currentNode:OnStepInto();
	-- 		end
	-- 	else
	-- 		callNextFrame(function()
	-- 			self.currentNode:OnStepOut();
	-- 			self.currentNode:Clean();
	-- 			self.currentNode = nextNode;
	-- 			if not self.isPaused then
	-- 				self.currentNode:OnStepInto();
	-- 			end
	-- 		end);
	-- 	end
	-- else
	-- 	if immediate then
	-- 		self.currentNode:OnStepOut();
	-- 		self:OnFinished();
	-- 		self:Clean();
	-- 	else
	-- 		callNextFrame(function ()
	-- 			self.currentNode:OnStepOut();
	-- 			self.currentNode:Clean();
	-- 			self.currentNode = nil;
	-- 			self:OnFinished();
	-- 			self:Clean();
	-- 		end);
	-- 	end
	-- end
end

function PZQueen:Count()
	local count = 0;
	local n = self.currentNode;
	while n do
		count = count + 1;
		if n.event then
			PZPrint("node event " .. n.event.__cname);
		end
		n = n.nextNode;
	end
	return count;
end

function PZQueen:IsRunning()
	if self.currentNode then
		return true;
	else
		return false;
	end
end

function PZQueen:OnLaunch()
	
end

function PZQueen:OnFinished()
	
end

function PZQueen:Contains(node)
	local n = self.firstNode;
	while true do
		if n == node then
			return true;
		elseif n.nextNode then
			n = n.nextNode;
		else
			return false;
		end
	end
end

function PZQueen:Append(node)
	if not self.firstNode or not self.currentNode then
		self:Launch(node);
		return;
	end
	node.queen = self;
	self.lastNode.nextNode = node;
	self.lastNode = node;
end

function PZQueen:Insert(node1, node2)
	if node1.queen ~= self then
		return;
	end

	if node1 == self.lastNode then
		self:Append(node2);
		return;
	end
	

	if node1.nextNode then
		node2.queen = self;
		local tNode = node1.nextNode;
		node1.nextNode = node2;
		node2.nextNode = tNode;
	end
end

function PZQueen:Clean()
	if self.firstNode then
		self.firstNode:Clean();
		self.firstNode = nil;
	end
	
	if self.lastNode then
		self.lastNode:Clean();
		self.lastNode = nil;
	end

	if self.currentNode then
		self.currentNode:Clean();
		self.currentNode = nil;
	end
end


PZQueenNode = class("PZQueenNode", PZClass);

function PZQueenNode:ctor()
	self.preNode = nil;
	self.nextNode = nil;
	self.queen = nil;	
end

function PZQueenNode:Clean()
	self.queen = nil;
	self.preNode = nil;
	self.nextNode = nil;
end

function PZQueenNode:OnStepInto()
	
end


function PZQueenNode:OnStepOut()
	
end


