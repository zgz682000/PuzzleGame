Level = class("Level", PZClass);

function Level:ctor(levelId)
	self.levelId = levelId;
	local levelMeta = LevelMeta[self.levelId];
	self.levelTarget = LevelTarget.Create(levelMeta.levelTarget);
	self.levelLimit = LevelLimit.Create(levelMeta.levelLimit);
end


LevelTarget = class("LevelTarget", PZClass);

function LevelTarget.Create(levelTarget)
	local ret = nil;
	if levelTarget.type == "remove_element" then
		ret = LevelTargetRemoveElement.New(levelTarget);
	elseif levelTarget.type == "discover_rune" then
		ret = LevelTargetDiscoverRune.New(levelTarget);
	elseif levelTarget.type == "score" then
		ret = LevelTargetScore.New(levelTarget);
	elseif levelTarget.type == "dispose_mine" then 
		ret = LevelTargetDisposeMine.New(levelTarget);
	end
	return ret;
end

LevelTargetRemoveElement = class("LevelTargetRemoveElement", LevelTarget);

LevelTargetDiscoverRune = class("LevelTargetDiscoverRune", LevelTarget);

LevelTargetScore = class("LevelTargetScore", LevelTarget);

LevelTargetDisposeMine = class("LevelTargetDisposeMine", LevelTarget);





LevelLimit = class("LevelLimit", PZClass);

function LevelLimit.Create(levelLimit)
	local ret = nil;
	if levelLimit.type == "round" then
		ret = LevelLimitRound.New(levelLimit);
	elseif levelLimit.type = "time" then
		ret = LevelLimitTime.New(levelLimit);
	end
	return ret;
end

LevelLimitRound = class("LevelLimitRound", LevelLimit);

LevelLimitTime = class("LevelLimitTime", LevelLimit);
