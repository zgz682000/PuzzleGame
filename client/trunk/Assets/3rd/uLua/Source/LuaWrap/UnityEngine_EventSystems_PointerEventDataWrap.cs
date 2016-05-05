using System;
using System.Collections.Generic;
using UnityEngine;
using LuaInterface;

public class UnityEngine_EventSystems_PointerEventDataWrap
{
	public static void Register(IntPtr L)
	{
		LuaMethod[] regs = new LuaMethod[]
		{
			new LuaMethod("IsPointerMoving", IsPointerMoving),
			new LuaMethod("IsScrolling", IsScrolling),
			new LuaMethod("ToString", ToString),
			new LuaMethod("New", _CreateUnityEngine_EventSystems_PointerEventData),
			new LuaMethod("GetClassType", GetClassType),
			new LuaMethod("__tostring", Lua_ToString),
		};

		LuaField[] fields = new LuaField[]
		{
			new LuaField("hovered", get_hovered, set_hovered),
			new LuaField("pointerEnter", get_pointerEnter, set_pointerEnter),
			new LuaField("lastPress", get_lastPress, null),
			new LuaField("rawPointerPress", get_rawPointerPress, set_rawPointerPress),
			new LuaField("pointerDrag", get_pointerDrag, set_pointerDrag),
			new LuaField("pointerCurrentRaycast", get_pointerCurrentRaycast, set_pointerCurrentRaycast),
			new LuaField("pointerPressRaycast", get_pointerPressRaycast, set_pointerPressRaycast),
			new LuaField("eligibleForClick", get_eligibleForClick, set_eligibleForClick),
			new LuaField("pointerId", get_pointerId, set_pointerId),
			new LuaField("position", get_position, set_position),
			new LuaField("delta", get_delta, set_delta),
			new LuaField("pressPosition", get_pressPosition, set_pressPosition),
			new LuaField("clickTime", get_clickTime, set_clickTime),
			new LuaField("clickCount", get_clickCount, set_clickCount),
			new LuaField("scrollDelta", get_scrollDelta, set_scrollDelta),
			new LuaField("useDragThreshold", get_useDragThreshold, set_useDragThreshold),
			new LuaField("dragging", get_dragging, set_dragging),
			new LuaField("button", get_button, set_button),
			new LuaField("enterEventCamera", get_enterEventCamera, null),
			new LuaField("pressEventCamera", get_pressEventCamera, null),
			new LuaField("pointerPress", get_pointerPress, set_pointerPress),
		};

		LuaScriptMgr.RegisterLib(L, "UnityEngine.EventSystems.PointerEventData", typeof(UnityEngine.EventSystems.PointerEventData), regs, fields, typeof(UnityEngine.EventSystems.BaseEventData));
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int _CreateUnityEngine_EventSystems_PointerEventData(IntPtr L)
	{
		int count = LuaDLL.lua_gettop(L);

		if (count == 1)
		{
			UnityEngine.EventSystems.EventSystem arg0 = (UnityEngine.EventSystems.EventSystem)LuaScriptMgr.GetUnityObject(L, 1, typeof(UnityEngine.EventSystems.EventSystem));
			UnityEngine.EventSystems.PointerEventData obj = new UnityEngine.EventSystems.PointerEventData(arg0);
			LuaScriptMgr.PushObject(L, obj);
			return 1;
		}
		else
		{
			LuaDLL.luaL_error(L, "invalid arguments to method: UnityEngine.EventSystems.PointerEventData.New");
		}

		return 0;
	}

	static Type classType = typeof(UnityEngine.EventSystems.PointerEventData);

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GetClassType(IntPtr L)
	{
		LuaScriptMgr.Push(L, classType);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_hovered(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name hovered");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index hovered on a nil value");
			}
		}

		LuaScriptMgr.PushObject(L, obj.hovered);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_pointerEnter(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name pointerEnter");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index pointerEnter on a nil value");
			}
		}

		LuaScriptMgr.Push(L, obj.pointerEnter);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_lastPress(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name lastPress");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index lastPress on a nil value");
			}
		}

		LuaScriptMgr.Push(L, obj.lastPress);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_rawPointerPress(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name rawPointerPress");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index rawPointerPress on a nil value");
			}
		}

		LuaScriptMgr.Push(L, obj.rawPointerPress);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_pointerDrag(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name pointerDrag");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index pointerDrag on a nil value");
			}
		}

		LuaScriptMgr.Push(L, obj.pointerDrag);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_pointerCurrentRaycast(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name pointerCurrentRaycast");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index pointerCurrentRaycast on a nil value");
			}
		}

		LuaScriptMgr.PushValue(L, obj.pointerCurrentRaycast);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_pointerPressRaycast(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name pointerPressRaycast");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index pointerPressRaycast on a nil value");
			}
		}

		LuaScriptMgr.PushValue(L, obj.pointerPressRaycast);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_eligibleForClick(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name eligibleForClick");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index eligibleForClick on a nil value");
			}
		}

		LuaScriptMgr.Push(L, obj.eligibleForClick);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_pointerId(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name pointerId");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index pointerId on a nil value");
			}
		}

		LuaScriptMgr.Push(L, obj.pointerId);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_position(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name position");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index position on a nil value");
			}
		}

		LuaScriptMgr.Push(L, obj.position);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_delta(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name delta");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index delta on a nil value");
			}
		}

		LuaScriptMgr.Push(L, obj.delta);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_pressPosition(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name pressPosition");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index pressPosition on a nil value");
			}
		}

		LuaScriptMgr.Push(L, obj.pressPosition);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_clickTime(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name clickTime");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index clickTime on a nil value");
			}
		}

		LuaScriptMgr.Push(L, obj.clickTime);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_clickCount(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name clickCount");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index clickCount on a nil value");
			}
		}

		LuaScriptMgr.Push(L, obj.clickCount);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_scrollDelta(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name scrollDelta");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index scrollDelta on a nil value");
			}
		}

		LuaScriptMgr.Push(L, obj.scrollDelta);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_useDragThreshold(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name useDragThreshold");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index useDragThreshold on a nil value");
			}
		}

		LuaScriptMgr.Push(L, obj.useDragThreshold);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_dragging(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name dragging");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index dragging on a nil value");
			}
		}

		LuaScriptMgr.Push(L, obj.dragging);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_button(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name button");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index button on a nil value");
			}
		}

		LuaScriptMgr.Push(L, obj.button);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_enterEventCamera(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name enterEventCamera");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index enterEventCamera on a nil value");
			}
		}

		LuaScriptMgr.Push(L, obj.enterEventCamera);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_pressEventCamera(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name pressEventCamera");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index pressEventCamera on a nil value");
			}
		}

		LuaScriptMgr.Push(L, obj.pressEventCamera);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_pointerPress(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name pointerPress");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index pointerPress on a nil value");
			}
		}

		LuaScriptMgr.Push(L, obj.pointerPress);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_hovered(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name hovered");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index hovered on a nil value");
			}
		}

		obj.hovered = (List<GameObject>)LuaScriptMgr.GetNetObject(L, 3, typeof(List<GameObject>));
		return 0;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_pointerEnter(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name pointerEnter");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index pointerEnter on a nil value");
			}
		}

		obj.pointerEnter = (GameObject)LuaScriptMgr.GetUnityObject(L, 3, typeof(GameObject));
		return 0;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_rawPointerPress(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name rawPointerPress");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index rawPointerPress on a nil value");
			}
		}

		obj.rawPointerPress = (GameObject)LuaScriptMgr.GetUnityObject(L, 3, typeof(GameObject));
		return 0;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_pointerDrag(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name pointerDrag");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index pointerDrag on a nil value");
			}
		}

		obj.pointerDrag = (GameObject)LuaScriptMgr.GetUnityObject(L, 3, typeof(GameObject));
		return 0;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_pointerCurrentRaycast(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name pointerCurrentRaycast");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index pointerCurrentRaycast on a nil value");
			}
		}

		obj.pointerCurrentRaycast = (UnityEngine.EventSystems.RaycastResult)LuaScriptMgr.GetNetObject(L, 3, typeof(UnityEngine.EventSystems.RaycastResult));
		return 0;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_pointerPressRaycast(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name pointerPressRaycast");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index pointerPressRaycast on a nil value");
			}
		}

		obj.pointerPressRaycast = (UnityEngine.EventSystems.RaycastResult)LuaScriptMgr.GetNetObject(L, 3, typeof(UnityEngine.EventSystems.RaycastResult));
		return 0;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_eligibleForClick(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name eligibleForClick");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index eligibleForClick on a nil value");
			}
		}

		obj.eligibleForClick = LuaScriptMgr.GetBoolean(L, 3);
		return 0;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_pointerId(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name pointerId");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index pointerId on a nil value");
			}
		}

		obj.pointerId = (int)LuaScriptMgr.GetNumber(L, 3);
		return 0;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_position(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name position");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index position on a nil value");
			}
		}

		obj.position = LuaScriptMgr.GetVector2(L, 3);
		return 0;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_delta(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name delta");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index delta on a nil value");
			}
		}

		obj.delta = LuaScriptMgr.GetVector2(L, 3);
		return 0;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_pressPosition(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name pressPosition");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index pressPosition on a nil value");
			}
		}

		obj.pressPosition = LuaScriptMgr.GetVector2(L, 3);
		return 0;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_clickTime(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name clickTime");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index clickTime on a nil value");
			}
		}

		obj.clickTime = (float)LuaScriptMgr.GetNumber(L, 3);
		return 0;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_clickCount(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name clickCount");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index clickCount on a nil value");
			}
		}

		obj.clickCount = (int)LuaScriptMgr.GetNumber(L, 3);
		return 0;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_scrollDelta(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name scrollDelta");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index scrollDelta on a nil value");
			}
		}

		obj.scrollDelta = LuaScriptMgr.GetVector2(L, 3);
		return 0;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_useDragThreshold(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name useDragThreshold");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index useDragThreshold on a nil value");
			}
		}

		obj.useDragThreshold = LuaScriptMgr.GetBoolean(L, 3);
		return 0;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_dragging(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name dragging");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index dragging on a nil value");
			}
		}

		obj.dragging = LuaScriptMgr.GetBoolean(L, 3);
		return 0;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_button(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name button");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index button on a nil value");
			}
		}

		obj.button = (UnityEngine.EventSystems.PointerEventData.InputButton)LuaScriptMgr.GetNetObject(L, 3, typeof(UnityEngine.EventSystems.PointerEventData.InputButton));
		return 0;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_pointerPress(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name pointerPress");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index pointerPress on a nil value");
			}
		}

		obj.pointerPress = (GameObject)LuaScriptMgr.GetUnityObject(L, 3, typeof(GameObject));
		return 0;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Lua_ToString(IntPtr L)
	{
		object obj = LuaScriptMgr.GetLuaObject(L, 1);

		if (obj != null)
		{
			LuaScriptMgr.Push(L, obj.ToString());
		}
		else
		{
			LuaScriptMgr.Push(L, "Table: UnityEngine.EventSystems.PointerEventData");
		}

		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int IsPointerMoving(IntPtr L)
	{
		LuaScriptMgr.CheckArgsCount(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)LuaScriptMgr.GetNetObjectSelf(L, 1, "UnityEngine.EventSystems.PointerEventData");
		bool o = obj.IsPointerMoving();
		LuaScriptMgr.Push(L, o);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int IsScrolling(IntPtr L)
	{
		LuaScriptMgr.CheckArgsCount(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)LuaScriptMgr.GetNetObjectSelf(L, 1, "UnityEngine.EventSystems.PointerEventData");
		bool o = obj.IsScrolling();
		LuaScriptMgr.Push(L, o);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int ToString(IntPtr L)
	{
		LuaScriptMgr.CheckArgsCount(L, 1);
		UnityEngine.EventSystems.PointerEventData obj = (UnityEngine.EventSystems.PointerEventData)LuaScriptMgr.GetNetObjectSelf(L, 1, "UnityEngine.EventSystems.PointerEventData");
		string o = obj.ToString();
		LuaScriptMgr.Push(L, o);
		return 1;
	}
}

