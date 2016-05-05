require "battle.behaviours.MoveCellBehaviour"

MoveCellLineBombBehaviour = class("MoveCellLineBombBehaviour", MoveCellBehaviour);

function MoveCellLineBombBehaviour:Start()
	MoveCellBehaviour.Start(self);

	self:RunBubbleAction(self.bubble);

	self:RunArrowAction(self.arrow_1, 10);
	self:RunArrowAction(self.arrow_2, -10);

	self.arrows.transform.localEulerAngles = Vector3.New(0,0, -60 * (self.cell.direction.index - 1));
end


function MoveCellLineBombBehaviour:RunArrowActionOnce(obj, offset, callback)
	local time = 0.75;
	iTween.MoveTo(obj, createITweenHash(self.gameObject, function ()
		iTween.MoveTo(obj, createITweenHash(self.gameObject, callback, "position", obj.transform.localPosition + Vector3.New(0, -offset, 0), "time", time, "islocal", true, "easetype" , "linear"));
	end, "position", obj.transform.localPosition + Vector3.New(0, offset, 0), "time", time, "islocal", true, "easetype" , "linear"));
end

function MoveCellLineBombBehaviour:RunArrowAction(obj, offset)
	self:RunArrowActionOnce(obj, offset, function ()
		self:RunArrowAction(obj, offset);
	end);
end


function MoveCellLineBombBehaviour:RunBubbleActionOnce(gameObject, scaleMode, delay, callback)
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

function MoveCellLineBombBehaviour:RunBubbleAction(gameObject)
	local randomDelay = math.random(3, 10);
	local randomScaleMode = math.random(1,3);
	self:RunBubbleActionOnce(gameObject, randomScaleMode, randomDelay, function ()
		self:RunBubbleAction(gameObject);
	end);
end

function MoveCellLineBombBehaviour:OnDestroy()
	if self.bubbleActionTimer then
		self.bubbleActionTimer:Stop();
	end
end