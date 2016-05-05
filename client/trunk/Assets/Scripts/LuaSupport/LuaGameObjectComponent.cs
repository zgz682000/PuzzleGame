using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using LuaInterface;
public class LuaGameObjectComponent : LuaExtensionComponent{
	public List<string> names;
	public List<GameObject> gameObjects;
	// Use this for initialization
	public override void OnLuaBehaviourInitalized(LuaTable luaB){
		base.OnLuaBehaviourInitalized (luaB);
		int i = 0;
		foreach (GameObject obj in gameObjects) {
			string objName = names[i];
			luaBehaviour[objName] = obj;
			i++;
		}
	}
}
