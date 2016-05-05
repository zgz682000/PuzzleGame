using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using LitJson;
using System.IO;
using System.Text;
using System.Security.Cryptography;
using System;
using LuaInterface;

public class VersionManager  {
	public static readonly string kDownloadPath = null;

	private static List<string> versionCodes = null;
	public static VersionInfo localVersionInfo = null;
	public static string GetLocalVersion(){
		if (localVersionInfo == null) {
			InitLocalVersionInfo();		
		}
		return localVersionInfo.versionCode;
	}
	static VersionManager(){
		kDownloadPath = AssetBundleManager.kAssetBundlesPath;
	}

	public static void InitLocalVersionInfo(){
		var localVersionFileContent = AssetBundleManager.ReadLocalConfigFileContent("BundleConfig");
		if (localVersionFileContent != null) {
			localVersionInfo = new VersionInfo();
			var d = JsonMapper.ToObject(localVersionFileContent);
			localVersionInfo.Encode(d);
		}
	}
#if UNITY_EDITOR
	public static void SaveLocalVersionInfo(string path){
		if (localVersionInfo == null) {
			return;
		}
		JsonData r = new JsonData ();
		r.SetJsonType (JsonType.Object);
		localVersionInfo.Decode (r);
		JsonWriter jw = new JsonWriter ();
		jw.PrettyPrint = true;
		r.ToJson(jw);
		string s = jw.ToString ();
		AssetBundleManager.SaveLocalConfigFile (s, path);
	}

	public static void InitVersionCodes(string target){
		if (versionCodes != null) {
			return;		
		}
		string versionsPath = Application.dataPath + "/../../../build/patchers/versions.json";
		if (File.Exists (versionsPath)) {
			var f = File.Open (versionsPath, FileMode.OpenOrCreate, FileAccess.Read);
			byte[] d = new byte[f.Length];
			f.Read (d, 0, (int)f.Length);
			string versionsContent = UTF8Encoding.UTF8.GetString (d);
			versionCodes = ParseVersionCodes (versionsContent);
			f.Close();
		} else {
			versionCodes = new List<string>();
		}
	}

	public static void SaveVersionCodes(string target){
		if (versionCodes == null) {
			InitVersionCodes(target);
		}
		if (localVersionInfo != null) {
			if (!versionCodes.Contains(localVersionInfo.versionCode)) {
				versionCodes.Add(localVersionInfo.versionCode);		
			}
		}

		JsonWriter w = new JsonWriter ();
		w.PrettyPrint = true;
		JsonData vsjd = new JsonData ();
		vsjd.SetJsonType (JsonType.Array);
		foreach (string v in versionCodes) {
			vsjd.Add(v);
		}
		vsjd.ToJson (w);
		string versionsContent = w.ToString ();
		byte[] versionsData = UTF8Encoding.UTF8.GetBytes (versionsContent);
		string versionsPath = Application.dataPath + "/../../../build/patchers/versions.json";
		var f = File.Open (versionsPath, FileMode.OpenOrCreate, FileAccess.Write);
		f.Write (versionsData, 0, versionsData.Length);
		f.Close ();
	}
#endif
	public delegate void CheckVersionCallback(bool isLatestVersion, string errorMsg);

	public static void CheckVersion(string url, CheckVersionCallback callback , MonoBehaviour context){
		if (versionCodes != null) {
			DoCheckVersion(url, callback);
			return;
		}
		context.StartCoroutine(DownloadVersionFile (url, delegate(WWW versionWWW) {
			if (versionWWW.error != null){
				callback(true, versionWWW.error);
				return;
			}
			if (versionWWW.text != null){
				versionCodes = ParseVersionCodes(versionWWW.text);
				DoCheckVersion(url, callback);
			}
		}));
	}
	private static void DoCheckVersion(string url, CheckVersionCallback callback){
		if (versionCodes != null) {
			int localVersionIndex = versionCodes.IndexOf(localVersionInfo.versionCode);
			bool isLatestVersion = false;
			if (localVersionIndex == versionCodes.Count - 1){
				isLatestVersion = true;
			}
			callback(isLatestVersion, null);	
		}
	}
	public delegate void UpdateProgressCallback(float percent);
	public delegate void UpdateResultCallback(string errorMsg);

	public static void UpdateToLatestVersion(string url, UpdateProgressCallback progressCallback, UpdateResultCallback resultCallback, MonoBehaviour context){
		CheckVersion(url, delegate(bool isLatestVersion, string errorMsg) {
			if (isLatestVersion){
				progressCallback(100);
				resultCallback(errorMsg);
			}else{
				context.StartCoroutine(DoUpdateToLatestVersion(url, progressCallback, resultCallback, context));
			}
		}, context);
	}
	private static IEnumerator DoUpdateToLatestVersion(string url, UpdateProgressCallback progressCallback, UpdateResultCallback resultCallback, MonoBehaviour context){
		int localVersionIndex = versionCodes.IndexOf(localVersionInfo.versionCode);
		Dictionary <string, BundleInfo> bundleInfos = new Dictionary<string, BundleInfo> (); 
		string error = null;
		for (int i = localVersionIndex + 1; i < versionCodes.Count; i++) {
			string versionCode = versionCodes[i];
			string text = null;
			yield return context.StartCoroutine(DownloadBundleConfigFile(url, versionCode, delegate(WWW www) {
				if (www.error != null){
					error = www.error;
					return;
				}
				AssetBundleManager.UnloadBundle("Config");
				if (www.assetBundle != null){
					AssetBundleManager.loadedBundles.Add("Config", www.assetBundle);
					TextAsset a = www.assetBundle.LoadAsset("BundleConfig") as TextAsset;
					if (a == null){
						error = "BundleConfig not found";
						www.assetBundle.Unload(true);
						return;
					}
					text = AESEncryptor.Decrypt(a.text);
				}
			}));
			if (error != null){
				resultCallback(error);
				yield break;
			}
			if (text != null){
				JsonData jd = JsonMapper.ToObject(text);
				VersionInfo v = new VersionInfo();
				v.Encode(jd);
				foreach(BundleInfo b in v.bundleInfos){
					b.versionCode = v.versionCode;
					if(bundleInfos.ContainsKey(b.name)){
						if (bundleInfos[b.name].md5 == null || b.md5 == null || bundleInfos[b.name].md5 != b.md5){
							bundleInfos.Remove(b.name);
							bundleInfos.Add(b.name, b);
						}
					}else{
						BundleInfo localBundleInfo = localVersionInfo.GetBundleInfoByName(b.name);
						if (localBundleInfo == null || localBundleInfo.md5 == null || b.md5 == null || localBundleInfo.md5 != b.md5){
							bundleInfos.Add(b.name, b);
						}
					}
				}
			}
			progressCallback(10.0f / (versionCodes.Count - localVersionIndex - 1) * (i - localVersionIndex));
		}

		float progressStep = 100.0f / bundleInfos.Count;
		float progress = 0;
		foreach (var i in bundleInfos) {
			BundleInfo b = i.Value;
			BundleInfo localVersionBundle = localVersionInfo.GetBundleInfoByName(b.name);
			if (localVersionBundle != null && localVersionBundle.md5 != null && b.md5 != null && localVersionBundle.md5 == b.md5){
				progress += progressStep; 
				progress = Mathf.Min(progress, 100);
				progressCallback(progress);
				continue;
			}
			byte[] bytes = null;
			yield return context.StartCoroutine(DownloadVersionBundle(url, b.versionCode, b.name, delegate(WWW www) {
				if (www.error != null){
					error = www.error;
					return;
				}
				if (www.bytes != null){
					bytes = www.bytes;
				}
			}));
			if (error != null){
				resultCallback(error);
				yield break;
			}
			if (bytes != null){
				if (!Directory.Exists(kDownloadPath)){
					Directory.CreateDirectory(kDownloadPath);
				}
				if (b.md5 != null){
					string md5 = AESEncryptor.GetMd5(bytes);
					if(md5 != b.md5){
						resultCallback(b.name + " md5 error");
						yield break;
					}
				}
				try{
					var f = File.Open(kDownloadPath + "/" + AESEncryptor.GetMd5(b.name) + ".stp", FileMode.OpenOrCreate, FileAccess.Write);
					f.Write(bytes, 0, bytes.Length);
					f.Close();
				}catch (Exception e){
					resultCallback(b.name + " write error" + e.Message);
					yield break;
				}
			}
			progress += progressStep; 
			progress = Mathf.Min(progress, 100);
			progressCallback(progress);
		}
		InitLocalVersionInfo();
		resultCallback (null);
	}
	private delegate void HandleFinishDownload(WWW www);
	private static IEnumerator DownloadVersionBundle(string url, string versionCode, string bundleName, HandleFinishDownload callback){
		string target = null;
		if (Application.platform == RuntimePlatform.Android) {
			target = "android";
		} else if (Application.platform == RuntimePlatform.IPhonePlayer) {
			target = "ios";
		}
		WWW versionBundleWWW = new WWW (url + "/" + versionCode + "_" + target + "_" + bundleName + ".stp");
		yield return versionBundleWWW;
		if (callback != null) {
			callback(versionBundleWWW);		
		}
	}
	private static IEnumerator DownloadVersionFile(string url, HandleFinishDownload callback){
		string target = null;
		if (Application.platform == RuntimePlatform.Android) {
			target = "android";
		} else if (Application.platform == RuntimePlatform.IPhonePlayer) {
			target = "ios";
		}
		WWW versionWWW = new WWW (url + "/versions.json");
		yield return versionWWW;
		if (callback != null) {
			callback(versionWWW);		
		}
	}
	private static IEnumerator DownloadBundleConfigFile(string url, string versionCode, HandleFinishDownload callback){
		string target = null;
		if (Application.platform == RuntimePlatform.Android) {
			target = "android";
		} else if (Application.platform == RuntimePlatform.IPhonePlayer) {
			target = "ios";
		}
		WWW versionWWW = new WWW (url + "/" + versionCode  + "_" + target + "_Config.stp");
		yield return versionWWW;
		if (callback != null) {
			callback(versionWWW);		
		}
	}
	private static List<string> ParseVersionCodes(string json){
		JsonData versionsObj = JsonMapper.ToObject(json);
		if (!versionsObj.IsArray) {
			return null;		
		}
		List<string> ret = new List<string> ();
		for (int i = 0; i < versionsObj.Count; i++){
			ret.Add((string)versionsObj[i]);
		}
		return ret;
	}

	public static string GetBundleFullName(string name, string target){
		string fullname = VersionManager.GetLocalVersion () + "_" + target + "_" + name + ".stp";
		return fullname;
	}

	public static void Register(IntPtr L)
	{
		LuaMethod[] regs = new LuaMethod[]
		{
			new LuaMethod("GetLocalVersion", Lua_GetLocalVersion)
		};
		LuaField[] fields = new LuaField[]
		{
		};
		LuaScriptMgr.RegisterLib(L, "VersionManager", typeof(VersionManager), regs, fields, typeof(object));
	}
	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	public static int Lua_GetLocalVersion(IntPtr L){
		LuaScriptMgr.CheckArgsCount(L, 0);
		LuaScriptMgr.Push (L, GetLocalVersion());
		return 1;
	}
}
