using System;
using UnityEngine;
using LuaInterface;

public class CoroutineWrap
{
	public static void Register(IntPtr L)
	{
		LuaMethod[] regs = new LuaMethod[]
		{
			new LuaMethod("New", _CreateCoroutine),
			new LuaMethod("GetClassType", GetClassType),
		};

		LuaField[] fields = new LuaField[]
		{
		};

		LuaScriptMgr.RegisterLib(L, "UnityEngine.Coroutine", typeof(Coroutine), regs, fields, typeof(YieldInstruction));
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int _CreateCoroutine(IntPtr L)
	{
		LuaDLL.luaL_error(L, "Coroutine class does not have a constructor function");
		return 0;
	}

	static Type classType = typeof(Coroutine);

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GetClassType(IntPtr L)
	{
		LuaScriptMgr.Push(L, classType);
		return 1;
	}
}

