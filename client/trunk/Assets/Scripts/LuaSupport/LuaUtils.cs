using System;
using LuaInterface;
using UnityEngine;
public static class LuaUtils
{	

	static LuaEntry entry = null;
	public static void Register(IntPtr L)
	{
		LuaMethod[] regs = new LuaMethod[]
		{
			
		};
		LuaField[] fields = new LuaField[]
		{
			
		};
		LuaScriptMgr.RegisterLib(L, "LuaUtils", typeof(LuaUtils), regs, fields, typeof(object));
	}
}
