using System;
using System.Collections.Generic;

public static class LuaBinder
{
	public static List<string> wrapList = new List<string>();
	public static void Bind(IntPtr L, string type = null)
	{
		if (type == null || wrapList.Contains(type)) return;
		wrapList.Add(type); type += "Wrap";
		switch (type) {
			case "AnimationBlendModeWrap": AnimationBlendModeWrap.Register(L); break;
			case "AnimationClipWrap": AnimationClipWrap.Register(L); break;
			case "AnimationStateWrap": AnimationStateWrap.Register(L); break;
			case "AnimationWrap": AnimationWrap.Register(L); break;
			case "AppConstWrap": AppConstWrap.Register(L); break;
			case "ApplicationWrap": ApplicationWrap.Register(L); break;
			case "AssetBundleWrap": AssetBundleWrap.Register(L); break;
			case "AsyncOperationWrap": AsyncOperationWrap.Register(L); break;
			case "AudioClipWrap": AudioClipWrap.Register(L); break;
			case "AudioSourceWrap": AudioSourceWrap.Register(L); break;
			case "BehaviourWrap": BehaviourWrap.Register(L); break;
			case "BlendWeightsWrap": BlendWeightsWrap.Register(L); break;
			case "BoxColliderWrap": BoxColliderWrap.Register(L); break;
			case "CameraClearFlagsWrap": CameraClearFlagsWrap.Register(L); break;
			case "CameraWrap": CameraWrap.Register(L); break;
			case "CharacterControllerWrap": CharacterControllerWrap.Register(L); break;
			case "ColliderWrap": ColliderWrap.Register(L); break;
			case "ComponentWrap": ComponentWrap.Register(L); break;
			case "CoroutineWrap": CoroutineWrap.Register(L); break;
			case "DebuggerWrap": DebuggerWrap.Register(L); break;
			case "DelegateFactoryWrap": DelegateFactoryWrap.Register(L); break;
			case "DelegateWrap": DelegateWrap.Register(L); break;
			case "EnumWrap": EnumWrap.Register(L); break;
			case "GCWrap": GCWrap.Register(L); break;
			case "GameObjectWrap": GameObjectWrap.Register(L); break;
			case "IEnumeratorWrap": IEnumeratorWrap.Register(L); break;
			case "InputWrap": InputWrap.Register(L); break;
			case "KeyCodeWrap": KeyCodeWrap.Register(L); break;
			case "LightTypeWrap": LightTypeWrap.Register(L); break;
			case "LightWrap": LightWrap.Register(L); break;
			case "MaterialWrap": MaterialWrap.Register(L); break;
			case "MeshColliderWrap": MeshColliderWrap.Register(L); break;
			case "MeshRendererWrap": MeshRendererWrap.Register(L); break;
			case "MonoBehaviourWrap": MonoBehaviourWrap.Register(L); break;
			case "ObjectWrap": ObjectWrap.Register(L); break;
			case "ParticleAnimatorWrap": ParticleAnimatorWrap.Register(L); break;
			case "ParticleEmitterWrap": ParticleEmitterWrap.Register(L); break;
			case "ParticleRendererWrap": ParticleRendererWrap.Register(L); break;
			case "ParticleSystemWrap": ParticleSystemWrap.Register(L); break;
			case "PhysicsWrap": PhysicsWrap.Register(L); break;
			case "PlayModeWrap": PlayModeWrap.Register(L); break;
			case "QualitySettingsWrap": QualitySettingsWrap.Register(L); break;
			case "QueueModeWrap": QueueModeWrap.Register(L); break;
			case "RectTransformWrap": RectTransformWrap.Register(L); break;
			case "RectWrap": RectWrap.Register(L); break;
			case "RenderSettingsWrap": RenderSettingsWrap.Register(L); break;
			case "RenderTextureWrap": RenderTextureWrap.Register(L); break;
			case "RendererWrap": RendererWrap.Register(L); break;
			case "ResourcesWrap": ResourcesWrap.Register(L); break;
			case "RigidbodyWrap": RigidbodyWrap.Register(L); break;
			case "ScreenWrap": ScreenWrap.Register(L); break;
			case "ShaderWrap": ShaderWrap.Register(L); break;
			case "SkinnedMeshRendererWrap": SkinnedMeshRendererWrap.Register(L); break;
			case "SleepTimeoutWrap": SleepTimeoutWrap.Register(L); break;
			case "SpaceWrap": SpaceWrap.Register(L); break;
			case "SphereColliderWrap": SphereColliderWrap.Register(L); break;
			case "SpriteRendererWrap": SpriteRendererWrap.Register(L); break;
			case "SpriteWrap": SpriteWrap.Register(L); break;
			case "StaticBatchingUtilityWrap": StaticBatchingUtilityWrap.Register(L); break;
			case "System_ObjectWrap": System_ObjectWrap.Register(L); break;
			case "Texture2DWrap": Texture2DWrap.Register(L); break;
			case "TextureWrap": TextureWrap.Register(L); break;
			case "TimeWrap": TimeWrap.Register(L); break;
			case "TouchPhaseWrap": TouchPhaseWrap.Register(L); break;
			case "TrackedReferenceWrap": TrackedReferenceWrap.Register(L); break;
			case "TransformWrap": TransformWrap.Register(L); break;
			case "TypeWrap": TypeWrap.Register(L); break;
			case "UnityEngine_EventSystems_BaseEventDataWrap": UnityEngine_EventSystems_BaseEventDataWrap.Register(L); break;
			case "UnityEngine_EventSystems_PointerEventDataWrap": UnityEngine_EventSystems_PointerEventDataWrap.Register(L); break;
			case "UnityEngine_SceneManagement_SceneManagerWrap": UnityEngine_SceneManagement_SceneManagerWrap.Register(L); break;
			case "UnityEngine_SceneManagement_SceneWrap": UnityEngine_SceneManagement_SceneWrap.Register(L); break;
			case "UnityEngine_UI_ImageWrap": UnityEngine_UI_ImageWrap.Register(L); break;
			case "UnityEngine_UI_InputFieldWrap": UnityEngine_UI_InputFieldWrap.Register(L); break;
			case "UnityEngine_UI_SelectableWrap": UnityEngine_UI_SelectableWrap.Register(L); break;
			case "UnityEngine_UI_TextWrap": UnityEngine_UI_TextWrap.Register(L); break;
			case "UtilWrap": UtilWrap.Register(L); break;
			case "WWWWrap": WWWWrap.Register(L); break;
			case "YieldInstructionWrap": YieldInstructionWrap.Register(L); break;
			case "iTweenWrap": iTweenWrap.Register(L); break;
			case "stringWrap": stringWrap.Register(L); break;
		}
	}
}
