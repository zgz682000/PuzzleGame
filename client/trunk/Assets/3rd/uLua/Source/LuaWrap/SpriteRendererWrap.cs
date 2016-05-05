using System;
using UnityEngine;
using LuaInterface;
using Object = UnityEngine.Object;

public class SpriteRendererWrap
{
	public static void Register(IntPtr L)
	{
		LuaMethod[] regs = new LuaMethod[]
		{
			new LuaMethod("New", _CreateSpriteRenderer),
			new LuaMethod("GetClassType", GetClassType),
			new LuaMethod("__eq", Lua_Eq),
		};

		LuaField[] fields = new LuaField[]
		{
			new LuaField("sprite", get_sprite, set_sprite),
			new LuaField("color", get_color, set_color),
			new LuaField("flipX", get_flipX, set_flipX),
			new LuaField("flipY", get_flipY, set_flipY),
		};

		LuaScriptMgr.RegisterLib(L, "UnityEngine.SpriteRenderer", typeof(SpriteRenderer), regs, fields, typeof(Renderer));
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int _CreateSpriteRenderer(IntPtr L)
	{
		int count = LuaDLL.lua_gettop(L);

		if (count == 0)
		{
			SpriteRenderer obj = new SpriteRenderer();
			LuaScriptMgr.Push(L, obj);
			return 1;
		}
		else
		{
			LuaDLL.luaL_error(L, "invalid arguments to method: SpriteRenderer.New");
		}

		return 0;
	}

	static Type classType = typeof(SpriteRenderer);

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GetClassType(IntPtr L)
	{
		LuaScriptMgr.Push(L, classType);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_sprite(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		SpriteRenderer obj = (SpriteRenderer)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name sprite");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index sprite on a nil value");
			}
		}

		LuaScriptMgr.Push(L, obj.sprite);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_color(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		SpriteRenderer obj = (SpriteRenderer)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name color");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index color on a nil value");
			}
		}

		LuaScriptMgr.Push(L, obj.color);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_flipX(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		SpriteRenderer obj = (SpriteRenderer)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name flipX");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index flipX on a nil value");
			}
		}

		LuaScriptMgr.Push(L, obj.flipX);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_flipY(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		SpriteRenderer obj = (SpriteRenderer)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name flipY");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index flipY on a nil value");
			}
		}

		LuaScriptMgr.Push(L, obj.flipY);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_sprite(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		SpriteRenderer obj = (SpriteRenderer)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name sprite");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index sprite on a nil value");
			}
		}

		obj.sprite = (Sprite)LuaScriptMgr.GetUnityObject(L, 3, typeof(Sprite));
		return 0;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_color(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		SpriteRenderer obj = (SpriteRenderer)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name color");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index color on a nil value");
			}
		}

		obj.color = LuaScriptMgr.GetColor(L, 3);
		return 0;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_flipX(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		SpriteRenderer obj = (SpriteRenderer)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name flipX");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index flipX on a nil value");
			}
		}

		obj.flipX = LuaScriptMgr.GetBoolean(L, 3);
		return 0;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_flipY(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		SpriteRenderer obj = (SpriteRenderer)o;

		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);

			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name flipY");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index flipY on a nil value");
			}
		}

		obj.flipY = LuaScriptMgr.GetBoolean(L, 3);
		return 0;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Lua_Eq(IntPtr L)
	{
		LuaScriptMgr.CheckArgsCount(L, 2);
		Object arg0 = LuaScriptMgr.GetLuaObject(L, 1) as Object;
		Object arg1 = LuaScriptMgr.GetLuaObject(L, 2) as Object;
		bool o = arg0 == arg1;
		LuaScriptMgr.Push(L, o);
		return 1;
	}
}

