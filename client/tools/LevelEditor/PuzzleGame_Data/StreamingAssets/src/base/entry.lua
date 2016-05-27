
if Application.isEditor and isDebugBuild then
	require("base.debuger");
end

require "base.PZClass";
require "base.LuaUtils";

require "data.Constant";
require "data.LevelMeta";
require "data.ElementMeta";
