ReplayManager = class("ReplayManager", PZClass)

ReplayManager.mode = nil;  -- "recoding" or "playing" or "disabled"

ReplayManager.currentReplay = nil;

ReplayManager.controlTimer = nil;

function ReplayManager.InitReplay(levelId)
	ReplayManager.mode = "recording";
	ReplayManager.currentReplay = {};
	ReplayManager.currentReplay.controls = {};
	ReplayManager.currentReplay.date = os.time();
	ReplayManager.currentReplay.levelId = levelId;
	ReplayManager.currentReplay.randoms = {};
end

function ReplayManager.RecordControl(control)
	if ReplayManager.mode ~= "recording" then
		return;
	end

	local controlObj = {
		controlDate = os.time(),
		controlType = control.__cname,
		controlParams = {}
	}

	control:Encode(controlObj.controlParams);

	table.insert(ReplayManager.currentReplay.controls, controlObj);
end

function ReplayManager.SaveReplay()
	if ReplayManager.mode ~= "recording" then
		return;
	end
	local replayText = PZClass.Serialize(ReplayManager.currentReplay);
	local replayFileName = tostring(os.date("%Y%m%d%H%M%S", ReplayManager.currentReplay.date)) .. ".bhr";
	local replayFilePath = Application.persistentDataPath .. "/" .. replayFileName;
	print(replayFilePath);
	local replayFile = io.open(replayFilePath, "w");
	replayFile:write(replayText);
	replayFile:close();
end

function ReplayManager.Clean()
	ReplayManager.mode = "disabled";
	ReplayManager.currentReplay = nil;
	if ReplayManager.controlTimer then
		ReplayManager.controlTimer:Stop();
		ReplayManager.controlTimer = nil;
	end
end

function ReplayManager.LoadReplay(name)
	ReplayManager.mode = "playing";
	local replayFilePath = Application.persistentDataPath .. "/" .. name;
	local replayFile = io.open(replayFilePath, "r");
	local replayText = replayFile:read("*a");
	ReplayManager.currentReplay = assert(loadstring("return " .. replayText)());

	return ReplayManager.currentReplay.levelId;
end

function ReplayManager.PlayRecord()
	if ReplayManager.mode ~= "playing" then
		return;
	end

	local now = os.time();

	local diff = now - ReplayManager.currentReplay.date;

	local offset = 1;
	
	local function StartControlTimer()
		local now = os.time();
		local control = ReplayManager.currentReplay.controls[offset];
		if control then
			local d = control.controlDate + diff - now;
			ReplayManager.controlTimer = Timer.New(function ()
				ReplayManager.InvokeBattleControl(control);
				offset = offset + 1;
				StartControlTimer();
			end, d);
			ReplayManager.controlTimer:Start();
		end
	end

	StartControlTimer();
end

function ReplayManager.InvokeBattleControl(controlObj)
	local controlClassName = controlObj.controlType;
	local controlClass = _G[controlClassName];
	local control = controlClass.New();
	control:Decode(controlObj.controlParams);
	control:Happen();
end


function ReplayManager.GetRandom(...)
	if ReplayManager.mode ~= "playing" then
		local ret = math.random(...);
		table.insert(ReplayManager.currentReplay.randoms, ret);
		return ret;
	else
		local ret = ReplayManager.currentReplay.randoms[1];
		table.remove(ReplayManager.currentReplay.randoms, 1);
		return ret;
	end
end