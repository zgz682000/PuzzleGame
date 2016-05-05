using System;
using UnityEngine;
using LuaInterface;

public class UnityEngine_EventSystems_BaseEventDataWrap
{
	public static void Register(IntPtr L)
	{
		LuaMethod[] regs = new LuaMethod[]
		{
			new LuaMethod("New", _CreateUnityEngine_EventSystems_BaseEventData),
			new LuaMethod("GetClassType", GetClassType),
		};

		LuaField[] fields = new LuaField[]
		{
			new LuaField("currentInputModule", get_currentInputModule, null),
			new LuaField("selectedObject", get_selectedObject, set_selectedObject),
		};

		LuaScriptMgr.RegisterLib(L, "UnityEngine.EventSystems.BaseEventData", typeof(UnityEngine.EventSystems.BaseEventData), regs, fields, typeof(UnityEngine.EventSystems.AbstractEventData));
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int _CreateUnityEngine_EventSystems_BaseEventData(IntPtr L)
	{
		int count = LuaDLL.lua_gettop(L);

		if (count == 1)
		{
			UnityEngine.EventSystems.EventSystem arg0 = (UnityEngine.EventSystems.EventSystem)LuaScriptMgr.GetUnityObject(L, 1, typeof(UnityEngine.EventSystems.EventSystem));
			UnityEngine.EventSystems.BaseEventData obj = new UnityEngine.EventSystems.BaseEventData(arg0);
			LuaScriptMgr.PushObject(L, obj);
			return 1;
		}
		else
		{
			LuaDLL.luaL_error(L, "invalid arguments to method: UnityEngine.EventSystems.BaseEventData.New");
		}

		return 0;
	}

	static Type classType = typeof(UnityEngine.EventSystems.BaseEventData);

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GetClassType(IntPtr L)
	{
		LuaScriptMgr.Push(L, classType);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_currentInputModule(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.BaseEventData obj = (UnityEngine.EventSystems.BaseEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name currentInputModule");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index currentInputModule on a nil value");
			}
		}

		LuaScriptMgr.Push(L, obj.currentInputModule);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_selectedObject(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.BaseEventData obj = (UnityEngine.EventSystems.BaseEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name selectedObject");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index selectedObject on a nil value");
			}
		}

		LuaScriptMgr.Push(L, obj.selectedObject);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_selectedObject(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.BaseEventData obj = (UnityEngine.EventSystems.BaseEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name selectedObject");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index selectedObject on a nil value");
			}
		}

		obj.selectedObject = (GameObject)LuaScriptMgr.GetUnityObject(L, 3, typeof(GameObject));
		return 0;
	}
}

