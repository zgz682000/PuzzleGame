require "battle.behaviours.BattleBehaviour"

TestBehaviour = class("TestBehaviour", LuaBehaviour);


function TestBehaviour:Start()
	local battleRoot = GameObject.Find("BattleRoot");
	local battleBehaviour = battleRoot:GetComponent("LuaComponent").luaBehaviour;
	battleBehaviour:InitWithLevelMetaId(90001);
end

