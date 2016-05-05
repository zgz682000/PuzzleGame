using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;
using LuaInterface;
public sealed class LuaComponent : MonoBehaviour {
	public string luaFilePath;
	public List<string> luaParamNames;
	public List<string> luaParamValues;
	public LuaTable luaBehaviour;
	public static void Register(IntPtr L)
	{
		LuaMethod[] regs = new LuaMethod[]
		{
		};
		LuaField[] fields = new LuaField[]
		{
			new LuaField("luaBehaviour", get_luaBehaviour, null)
		};
		LuaScriptMgr.RegisterLib(L, "LuaComponent", typeof(LuaComponent), regs, fields, typeof(MonoBehaviour));
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_luaBehaviour(IntPtr L)
	{
		object o = LuaScriptMgr.GetLuaObject(L, 1);
		LuaComponent obj = (LuaComponent)o;
		if (obj == null)
		{
			LuaTypes types = LuaDLL.lua_type(L, 1);
			
			if (types == LuaTypes.LUA_TTABLE)
			{
				LuaDLL.luaL_error(L, "unknown member name transform");
			}
			else
			{
				LuaDLL.luaL_error(L, "attempt to index transform on a nil value");
			}
		}
		
		LuaScriptMgr.Push(L, obj.luaBehaviour);
		return 1;
	}
	void Awake()
	{
		if(!string.IsNullOrEmpty(luaFilePath))
		{
			var lua = LuaEntry.SharedLua;
			lua.DoFile (luaFilePath);
			string[] pathComponents = luaFilePath.Split (new char[]{'/'});
			string luaFileName = pathComponents[pathComponents.Length - 1];
			string luaClassName = luaFileName.Replace (".lua", "");
			LuaTable luaBehaviourClass = lua.GetLuaTable (luaClassName);
			LuaFunction luaBehaviourCtor = (LuaFunction)luaBehaviourClass["New"];
			luaBehaviour = (LuaTable)(luaBehaviourCtor.Call (new object[]{this.name})[0]);

			luaBehaviour["gameObject"] = this.gameObject;

			int count = Mathf.Min (luaParamNames.Count, luaParamValues.Count);
			for (int i = 0; i < count; i++) {
				string luaParamName = luaParamNames[i];
				string luaParamValue = luaParamValues[i];
				luaBehaviour[luaParamName] = luaParamValue;
			}

			LuaExtensionComponent[] extensions = GetComponents<LuaExtensionComponent>();
			foreach (LuaExtensionComponent extension in extensions){
				extension.OnLuaBehaviourInitalized(luaBehaviour);
			}
		}
	}
	void Start () {	
		LuaFunction luaBehaviourStartFunc = (LuaFunction)luaBehaviour["Start"];
		if (luaBehaviourStartFunc != null) {
			luaBehaviourStartFunc.Call(new object[]{luaBehaviour});
		}
	}

	// void Update(){
	// 	LuaFunction luaBehaviourUpdateFunc =(LuaFunction)luaBehaviour["Update"];
	// 	if (luaBehaviourUpdateFunc != null) {
	// 		luaBehaviourUpdateFunc.Call(new object[]{luaBehaviour});
	// 	}
	// }

	void OnDestroy(){
		LuaFunction luaBehaviourOnDestroyFunc = (LuaFunction)luaBehaviour["OnDestroy"];
		if (luaBehaviourOnDestroyFunc != null) {
			luaBehaviourOnDestroyFunc.Call(new object[]{luaBehaviour});
		}
	}
}
