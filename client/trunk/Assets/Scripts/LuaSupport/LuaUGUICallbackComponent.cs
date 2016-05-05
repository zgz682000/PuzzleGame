using UnityEngine;
using System.Collections;
using LuaInterface;
public class LuaUGUICallbackComponent : LuaExtensionComponent {
	public string callbackFunctionName;

	public void OnCallback(){			
		LuaFunction luaBehaviourStartFunc = (LuaFunction)luaBehaviour[callbackFunctionName];
		if(luaBehaviourStartFunc!=null)
		{
			luaBehaviourStartFunc.Call(luaBehaviour);
		}
	}

	public void OnCallback(GameObject sender){			
		LuaFunction luaBehaviourStartFunc = (LuaFunction)luaBehaviour[callbackFunctionName];
		if(luaBehaviourStartFunc!=null)
		{
			luaBehaviourStartFunc.Call(luaBehaviour, sender);
		}
	}

	public void OnCallback(string functionName){			
		LuaFunction luaBehaviourStartFunc = (LuaFunction)luaBehaviour[functionName];
		if(luaBehaviourStartFunc!=null)
		{
			luaBehaviourStartFunc.Call(luaBehaviour);
		}
	}
}
