using System;
using UnityEngine;
using System.Collections.Generic;
using LuaInterface;

public class UnityEngine_SceneManagement_SceneWrap
{
	public static void Register(IntPtr L)
	{
		LuaMethod[] regs = new LuaMethod[]
		{
			new LuaMethod("IsValid", IsValid),
			new LuaMethod("GetRootGameObjects", GetRootGameObjects),
			new LuaMethod("GetHashCode", GetHashCode),
			new LuaMethod("Equals", Equals),
			new LuaMethod("New", _CreateUnityEngine_SceneManagement_Scene),
			new LuaMethod("GetClassType", GetClassType),
			new LuaMethod("__eq", Lua_Eq),
		};

		LuaField[] fields = new LuaField[]
		{
			new LuaField("path", get_path, null),
			new LuaField("name", get_name, null),
			new LuaField("isLoaded", get_isLoaded, null),
			new LuaField("buildIndex", get_buildIndex, null),
			new LuaField("isDirty", get_isDirty, null),
			new LuaField("rootCount", get_rootCount, null),
		};

		LuaScriptMgr.RegisterLib(L, "UnityEngine.SceneManagement.Scene", typeof(UnityEngine.SceneManagement.Scene), regs, fields, null);
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int _CreateUnityEngine_SceneManagement_Scene(IntPtr L)
	{
		LuaScriptMgr.CheckArgsCount(L, 0);
		UnityEngine.SceneManagement.Scene obj = new UnityEngine.SceneManagement.Scene();
		LuaScriptMgr.PushValue(L, obj);
		return 1;
	}

	static Type classType = typeof(UnityEngine.SceneManagement.Scene);

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GetClassType(IntPtr L)
	{
		LuaScriptMgr.Push(L, classType);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_path(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);

		if (o == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name path");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index path on a nil value");
			}
		}

		UnityEngine.SceneManagement.Scene obj = (UnityEngine.SceneManagement.Scene)o;
		LuaScriptMgr.Push(L, obj.path);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_name(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);

		if (o == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name name");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index name on a nil value");
			}
		}

		UnityEngine.SceneManagement.Scene obj = (UnityEngine.SceneManagement.Scene)o;
		LuaScriptMgr.Push(L, obj.name);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_isLoaded(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);

		if (o == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name isLoaded");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index isLoaded on a nil value");
			}
		}

		UnityEngine.SceneManagement.Scene obj = (UnityEngine.SceneManagement.Scene)o;
		LuaScriptMgr.Push(L, obj.isLoaded);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_buildIndex(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);

		if (o == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name buildIndex");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index buildIndex on a nil value");
			}
		}

		UnityEngine.SceneManagement.Scene obj = (UnityEngine.SceneManagement.Scene)o;
		LuaScriptMgr.Push(L, obj.buildIndex);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_isDirty(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);

		if (o == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name isDirty");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index isDirty on a nil value");
			}
		}

		UnityEngine.SceneManagement.Scene obj = (UnityEngine.SceneManagement.Scene)o;
		LuaScriptMgr.Push(L, obj.isDirty);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_rootCount(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);

		if (o == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name rootCount");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index rootCount on a nil value");
			}
		}

		UnityEngine.SceneManagement.Scene obj = (UnityEngine.SceneManagement.Scene)o;
		LuaScriptMgr.Push(L, obj.rootCount);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int IsValid(IntPtr L)
	{
		LuaScriptMgr.CheckArgsCount(L, 1);
		UnityEngine.SceneManagement.Scene obj = (UnityEngine.SceneManagement.Scene)LuaScriptMgr.GetNetObjectSelf(L, 1, "UnityEngine.SceneManagement.Scene");
		bool o = obj.IsValid();
		LuaScriptMgr.Push(L, o);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GetRootGameObjects(IntPtr L)
	{
		int count = LuaDLL.lua_gettop(L);

		if (count == 1)
		{
			UnityEngine.SceneManagement.Scene obj = (UnityEngine.SceneManagement.Scene)LuaScriptMgr.GetNetObjectSelf(L, 1, "UnityEngine.SceneManagement.Scene");
			GameObject[] o = obj.GetRootGameObjects();
			LuaScriptMgr.PushArray(L, o);
			return 1;
		}
		else if (count == 2)
		{
			UnityEngine.SceneManagement.Scene obj = (UnityEngine.SceneManagement.Scene)LuaScriptMgr.GetNetObjectSelf(L, 1, "UnityEngine.SceneManagement.Scene");
			List<GameObject> arg0 = (List<GameObject>)LuaScriptMgr.GetNetObject(L, 2, typeof(List<GameObject>));
			obj.GetRootGameObjects(arg0);
			LuaScriptMgr.SetValueObject(L, 1, obj);
			return 0;
		}
		else
		{
			LuaDLL.luaL_error(L, "invalid arguments to method: UnityEngine.SceneManagement.Scene.GetRootGameObjects");
		}

		return 0;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GetHashCode(IntPtr L)
	{
		LuaScriptMgr.CheckArgsCount(L, 1);
		UnityEngine.SceneManagement.Scene obj = (UnityEngine.SceneManagement.Scene)LuaScriptMgr.GetNetObjectSelf(L, 1, "UnityEngine.SceneManagement.Scene");
		int o = obj.GetHashCode();
		LuaScriptMgr.Push(L, o);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Equals(IntPtr L)
	{
		LuaScriptMgr.CheckArgsCount(L, 2);
		UnityEngine.SceneManagement.Scene obj = (UnityEngine.SceneManagement.Scene)LuaScriptMgr.GetVarObject(L, 1);
		object arg0 = LuaScriptMgr.GetVarObject(L, 2);
		bool o = obj.Equals(arg0);
		LuaScriptMgr.Push(L, o);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Lua_Eq(IntPtr L)
	{
		LuaScriptMgr.CheckArgsCount(L, 2);
		UnityEngine.SceneManagement.Scene arg0 = (UnityEngine.SceneManagement.Scene)LuaScriptMgr.GetVarObject(L, 1);
		UnityEngine.SceneManagement.Scene arg1 = (UnityEngine.SceneManagement.Scene)LuaScriptMgr.GetVarObject(L, 2);
		bool o = arg0 == arg1;
		LuaScriptMgr.Push(L, o);
		return 1;
	}
}

