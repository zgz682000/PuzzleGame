require "battle.behaviours.MoveCellBehaviour"

MoveCellAreaBombBehaviour = class("MoveCellAreaBombBehaviour", MoveCellBehaviour)


function MoveCellAreaBombBehaviour:Start()
	MoveCellBehaviour.Start(self);

	self:RunBubbleAction(self.bubble);
end


function MoveCellAreaBombBehaviour:RunBubbleActionOnce(gameObject, scaleMode, delay, callback)
	local f = 0.8;
	local time = 2;
	self.bubbleActionTimer = Timer.New(function()
		if scaleMode == 1 then
			gameObject.transform.localScale = Vector3.New(f, f, 1);
		elseif scaleMode == 2 then
			gameObject.transform.localScale = Vector3.New(1, f, 1);
		elseif scaleMode == 3 then
			gameObject.transform.localScale = Vector3.New(f, 1, 1);
		end
		iTween.ScaleTo(gameObject, createITweenHash(gameObject,  nil, "scale", Vector3.New(1, 1, 1), "time", time, "islocal", true, "easetype", "easeOutElastic"));
		callback();
	end, delay);
	self.bubbleActionTimer:Start();
end

function MoveCellAreaBombBehaviour:RunBubbleAction(gameObject)
	local randomDelay = math.random(3, 10);
	local randomScaleMode = math.random(1,3);
	self:RunBubbleActionOnce(gameObject, randomScaleMode, randomDelay, function ()
		self:RunBubbleAction(gameObject);
	end);
end

function MoveCellAreaBombBehaviour:OnDestroy()
	if self.bubbleActionTimer then
		self.bubbleActionTimer:Stop();
	end
end