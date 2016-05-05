using System;
using UnityEngine;
using LuaInterface;

public class StaticBatchingUtilityWrap
{
	public static void Register(IntPtr L)
	{
		LuaMethod[] regs = new LuaMethod[]
		{
			new LuaMethod("Combine", Combine),
			new LuaMethod("New", _CreateStaticBatchingUtility),
			new LuaMethod("GetClassType", GetClassType),
		};

		LuaField[] fields = new LuaField[]
		{
		};

		LuaScriptMgr.RegisterLib(L, "UnityEngine.StaticBatchingUtility", typeof(StaticBatchingUtility), regs, fields, typeof(object));
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int _CreateStaticBatchingUtility(IntPtr L)
	{
		int count = LuaDLL.lua_gettop(L);

		if (count == 0)
		{
			StaticBatchingUtility obj = new StaticBatchingUtility();
			LuaScriptMgr.PushObject(L, obj);
			return 1;
		}
		else
		{
			LuaDLL.luaL_error(L, "invalid arguments to method: StaticBatchingUtility.New");
		}

		return 0;
	}

	static Type classType = typeof(StaticBatchingUtility);

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GetClassType(IntPtr L)
	{
		LuaScriptMgr.Push(L, classType);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Combine(IntPtr L)
	{
		int count = LuaDLL.lua_gettop(L);

		if (count == 1)
		{
			GameObject arg0 = (GameObject)LuaScriptMgr.GetUnityObject(L, 1, typeof(GameObject));
			StaticBatchingUtility.Combine(arg0);
			return 0;
		}
		else if (count == 2)
		{
			GameObject[] objs0 = LuaScriptMgr.GetArrayObject<GameObject>(L, 1);
			GameObject arg1 = (GameObject)LuaScriptMgr.GetUnityObject(L, 2, typeof(GameObject));
			StaticBatchingUtility.Combine(objs0,arg1);
			return 0;
		}
		else
		{
			LuaDLL.luaL_error(L, "invalid arguments to method: StaticBatchingUtility.Combine");
		}

		return 0;
	}
}

