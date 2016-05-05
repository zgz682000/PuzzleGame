using System;
using LuaInterface;
using UnityEngine.EventSystems;
using UnityEngine.UI;
using UnityEngine;

public class LuaUGUIEventComponent : LuaExtensionComponent
{
	public void OnDrag(BaseEventData eventData){	
		LuaFunction luaBehaviourStartFunc = (LuaFunction)luaBehaviour["OnDrag"];
		if(luaBehaviourStartFunc!=null)
		{
			luaBehaviourStartFunc.Call(luaBehaviour, eventData);
		}
	}

	public void OnClick(BaseEventData eventData){			
		LuaFunction luaBehaviourStartFunc = (LuaFunction)luaBehaviour["OnClick"];
		if(luaBehaviourStartFunc!=null)
		{
			luaBehaviourStartFunc.Call(luaBehaviour, eventData);
		}
	}

	public void OnBeginDrag(BaseEventData eventData){			
		LuaFunction luaBehaviourStartFunc = (LuaFunction)luaBehaviour["OnBeginDrag"];
		if(luaBehaviourStartFunc!=null)
		{
			luaBehaviourStartFunc.Call(luaBehaviour, eventData);
		}
	}

	public void OnEndDrag(BaseEventData eventData){
		LuaFunction luaBehaviourStartFunc = (LuaFunction)luaBehaviour["OnEndDrag"];
		if(luaBehaviourStartFunc!=null)
		{
			luaBehaviourStartFunc.Call(luaBehaviour, eventData);
		}
	}
}

