using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using LuaInterface;


public class LuaAtlasSpriteCarrier : LuaExtensionComponent {
	public List<Sprite> sprites;
	public override void OnLuaBehaviourInitalized (LuaInterface.LuaTable luaB)
	{
		base.OnLuaBehaviourInitalized (luaB);

		int reference = LuaDLL.luaL_ref(LuaEntry.SharedLua.lua.L, LuaIndexes.LUA_REGISTRYINDEX);
		var spritesLuaTable = new LuaTable(reference, LuaEntry.SharedLua.lua);;

		foreach (Sprite sp in sprites) {
			spritesLuaTable[sp.name] = sp;
		}
		luaB ["sprites"] = spritesLuaTable;
	}
}
