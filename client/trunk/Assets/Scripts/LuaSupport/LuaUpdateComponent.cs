using UnityEngine;
using System.Collections;
using LuaInterface;
public class LuaUpdateComponent : LuaExtensionComponent {

	// Update is called once per frame
	void Update () {
		LuaFunction luaBehaviourStartFunc = (LuaFunction)luaBehaviour["Update"];
		if(luaBehaviourStartFunc!=null)
		{
			luaBehaviourStartFunc.Call(new object[]{luaBehaviour});
		}
	}
}
