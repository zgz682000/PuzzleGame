using System;
using LuaInterface;

public class GCWrap
{
	public static void Register(IntPtr L)
	{
		LuaMethod[] regs = new LuaMethod[]
		{
			new LuaMethod("Collect", Collect),
			new LuaMethod("GetGeneration", GetGeneration),
			new LuaMethod("GetTotalMemory", GetTotalMemory),
			new LuaMethod("KeepAlive", KeepAlive),
			new LuaMethod("ReRegisterForFinalize", ReRegisterForFinalize),
			new LuaMethod("SuppressFinalize", SuppressFinalize),
			new LuaMethod("WaitForPendingFinalizers", WaitForPendingFinalizers),
			new LuaMethod("CollectionCount", CollectionCount),
			new LuaMethod("AddMemoryPressure", AddMemoryPressure),
			new LuaMethod("RemoveMemoryPressure", RemoveMemoryPressure),
			new LuaMethod("New", _CreateGC),
			new LuaMethod("GetClassType", GetClassType),
		};

		LuaField[] fields = new LuaField[]
		{
			new LuaField("MaxGeneration", get_MaxGeneration, null),
		};

		LuaScriptMgr.RegisterLib(L, "System.GC", typeof(GC), regs, fields, null);
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int _CreateGC(IntPtr L)
	{
		LuaDLL.luaL_error(L, "GC class does not have a constructor function");
		return 0;
	}

	static Type classType = typeof(GC);

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GetClassType(IntPtr L)
	{
		LuaScriptMgr.Push(L, classType);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_MaxGeneration(IntPtr L)
	{
		LuaScriptMgr.Push(L, GC.MaxGeneration);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Collect(IntPtr L)
	{
		int count = LuaDLL.lua_gettop(L);

		if (count == 0)
		{
			GC.Collect();
			return 0;
		}
		else if (count == 1)
		{
			int arg0 = (int)LuaScriptMgr.GetNumber(L, 1);
			GC.Collect(arg0);
			return 0;
		}
		else if (count == 2)
		{
			int arg0 = (int)LuaScriptMgr.GetNumber(L, 1);
			GCCollectionMode arg1 = (GCCollectionMode)LuaScriptMgr.GetNetObject(L, 2, typeof(GCCollectionMode));
			GC.Collect(arg0,arg1);
			return 0;
		}
		else
		{
			LuaDLL.luaL_error(L, "invalid arguments to method: GC.Collect");
		}

		return 0;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GetGeneration(IntPtr L)
	{
		int count = LuaDLL.lua_gettop(L);

		if (count == 1 && LuaScriptMgr.CheckTypes(L, 1, typeof(WeakReference)))
		{
			WeakReference arg0 = (WeakReference)LuaScriptMgr.GetLuaObject(L, 1);
			int o = GC.GetGeneration(arg0);
			LuaScriptMgr.Push(L, o);
			return 1;
		}
		else if (count == 1 && LuaScriptMgr.CheckTypes(L, 1, typeof(object)))
		{
			object arg0 = LuaScriptMgr.GetVarObject(L, 1);
			int o = GC.GetGeneration(arg0);
			LuaScriptMgr.Push(L, o);
			return 1;
		}
		else
		{
			LuaDLL.luaL_error(L, "invalid arguments to method: GC.GetGeneration");
		}

		return 0;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GetTotalMemory(IntPtr L)
	{
		LuaScriptMgr.CheckArgsCount(L, 1);
		bool arg0 = LuaScriptMgr.GetBoolean(L, 1);
		long o = GC.GetTotalMemory(arg0);
		LuaScriptMgr.Push(L, o);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int KeepAlive(IntPtr L)
	{
		LuaScriptMgr.CheckArgsCount(L, 1);
		object arg0 = LuaScriptMgr.GetVarObject(L, 1);
		GC.KeepAlive(arg0);
		return 0;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int ReRegisterForFinalize(IntPtr L)
	{
		LuaScriptMgr.CheckArgsCount(L, 1);
		object arg0 = LuaScriptMgr.GetVarObject(L, 1);
		GC.ReRegisterForFinalize(arg0);
		return 0;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int SuppressFinalize(IntPtr L)
	{
		LuaScriptMgr.CheckArgsCount(L, 1);
		object arg0 = LuaScriptMgr.GetVarObject(L, 1);
		GC.SuppressFinalize(arg0);
		return 0;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int WaitForPendingFinalizers(IntPtr L)
	{
		LuaScriptMgr.CheckArgsCount(L, 0);
		GC.WaitForPendingFinalizers();
		return 0;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int CollectionCount(IntPtr L)
	{
		LuaScriptMgr.CheckArgsCount(L, 1);
		int arg0 = (int)LuaScriptMgr.GetNumber(L, 1);
		int o = GC.CollectionCount(arg0);
		LuaScriptMgr.Push(L, o);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int AddMemoryPressure(IntPtr L)
	{
		LuaScriptMgr.CheckArgsCount(L, 1);
		long arg0 = (long)LuaScriptMgr.GetNumber(L, 1);
		GC.AddMemoryPressure(arg0);
		return 0;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int RemoveMemoryPressure(IntPtr L)
	{
		LuaScriptMgr.CheckArgsCount(L, 1);
		long arg0 = (long)LuaScriptMgr.GetNumber(L, 1);
		GC.RemoveMemoryPressure(arg0);
		return 0;
	}
}

