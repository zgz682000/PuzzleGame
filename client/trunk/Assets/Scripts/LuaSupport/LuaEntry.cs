using UnityEngine;
using System.Collections;
using LuaInterface;
using System.IO;
using System.Text;
public class LuaEntry : MonoBehaviour {
	public static LuaScriptMgr SharedLua {
		get;
		set;
	} 
#if !UNITY_IPHONE || UNITY_EDITOR
	void InitAndroidStreamAssets(){
		Directory.CreateDirectory (Application.persistentDataPath + "/src");
		AndroidStreamingAssetsLoad.EachAllFile ((string file) => 
		{
			if (file.StartsWith ("src/")){
				string subFileName = file.Substring(4);

				string subFilePath = Application.persistentDataPath + "/src/" + subFileName;
				if (File.Exists(subFilePath)){
					return;
				}
				string[] comps = subFileName.Split('/');
				if (comps.Length > 1) {
					string dirName = Application.persistentDataPath + "/src";
					for (int i = 0; i < comps.Length - 1; i++){
						dirName += "/" + comps[i];
						if(!Directory.Exists(dirName)){
							Directory.CreateDirectory (dirName);
						}
					}
				}

				Stream subFileStream = AndroidStreamingAssetsLoad.GetFile(file);
				byte[] subFileContent = new byte[subFileStream.Length];
				subFileStream.Read(subFileContent, 0, (int)subFileStream.Length);
				subFileStream.Close();
				FileStream wf = new FileStream(subFilePath, FileMode.OpenOrCreate);
				wf.Write(subFileContent, 0, subFileContent.Length);
				wf.Close();
			}
		});

		AndroidStreamingAssetsLoad.Release ();
	}
#endif
	// Use this for initialization
	public void Awake()
	{
		if (SharedLua != null) {
			return;		
		}
		Application.targetFrameRate = 60;

		if (Debug.isDebugBuild) {
			if (Application.platform == RuntimePlatform.Android){
#if !UNITY_IPHONE || UNITY_EDITOR
				InitAndroidStreamAssets();
#endif
				Util.AddSearchPath (Application.persistentDataPath + "/src");
			}
			else if (!Application.isEditor && Application.platform == RuntimePlatform.OSXPlayer){
				Util.AddSearchPath (Application.streamingAssetsPath + "/src");
				Util.AddSearchPath (Application.dataPath + "/../../../../trunk/Assets/StreamingAssets/src");
			}
			else if (!Application.isEditor && Application.platform == RuntimePlatform.WindowsPlayer){
				Util.AddSearchPath (Application.streamingAssetsPath + "/src");
				Util.AddSearchPath (Application.dataPath + "/../../../trunk/Assets/StreamingAssets/src");
			}
			else{
				Util.AddSearchPath (Application.streamingAssetsPath + "/src");
			}
		}
		SharedLua = new LuaScriptMgr ();
		SharedLua.beforeEnterLuaCallback = beforeEnterLua;
		SharedLua.Start ();

		LuaComponent.Register (SharedLua.GetL());
		VersionManager.Register (SharedLua.GetL ());
		if (!Debug.isDebugBuild) {
			AssetBundleManager.Register(SharedLua.GetL());
		}

		if (!Debug.isDebugBuild) {
			AssetBundleManager.Register(SharedLua.GetL());
#if QA_SERVER
			SharedLua.DoString ("QA_SERVER = true");
#elif ONLINE_SERVER
			SharedLua.DoString ("ONLINE_SERVER = true");
#endif
		}
		SharedLua.DoString ("isDebugBuild = " + Debug.isDebugBuild.ToString ().ToLower ());
		SharedLua.DoFile ("base/entry.lua");

	}
	void Start () {
	}
	public void beforeEnterLua(){
		if (!Debug.isDebugBuild) {
			LuaStatic.Load = Loader;
		}
	}
	// Update is called once per frame
	void Update () {
		SharedLua.Update ();
	}

	public byte[] Loader(string name)
	{
		SharedLua.fileList.Add(name);
		string lowerName = name.ToLower();
		if (lowerName.EndsWith(".lua")) {
			int index = name.LastIndexOf('.');
			name = name.Substring(0, index);
		}
		name = name.Replace('.', '/');
		var components = name.Split('/');
		var luaFileName = components [components.Length - 1] + ".lua";
		AssetBundle bundle = AssetBundleManager.GetBundle("src");
		if (bundle != null) {
			var textAsset = bundle.LoadAsset<TextAsset>(luaFileName);
			if (textAsset != null){
				var ret = AESEncryptor.Decrypt(textAsset.text);
				return Encoding.UTF8.GetBytes(ret);
			}
		}
		return null;
	}
}
