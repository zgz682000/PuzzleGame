
if Application.isEditor and isDebugBuild then
	require("base.debuger");
end

require "base.PZClass";

require "base.GameEventManager";
require "base.LuaUtils";
require "data.Metas";
require "data.Constant";



-- require "battle.model.HexagonGrid"
-- local p = HexagonGrid.GetPositionFromKey(625225);
-- local k = HexagonGrid.GetKeyFromPosition(p);
-- print(k);