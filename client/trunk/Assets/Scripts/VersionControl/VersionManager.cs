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

	public static WWW currentWWW = null;
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
		string localVersionFileContent = File.ReadAllText (kDownloadPath + "/BundleConfig.json");
		if (localVersionFileContent != null) {
			localVersionInfo = new VersionInfo();
			var d = JsonMapper.ToObject(localVersionFileContent);
			localVersionInfo.Encode(d);
		}
	}
	public delegate void CheckVersionCallback(bool isLatestVersion, string errorMsg);

	public static void CheckVersion(string url, CheckVersionCallback callback , MonoBehaviour context){
		if (versionCodes != null) {
			DoCheckVersion(url, callback);
			return;
		}
		context.StartCoroutine(DownloadVersionFile (url, delegate(WWW versionWWW) {
			if (versionWWW.error != null){
				callback(false, versionWWW.error);
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


	public delegate void GetPackageBundleVersionCallback(string version, string error);
	public static IEnumerator GetPackageBundleVersion(GetPackageBundleVersionCallback callback){
		AssetBundleManager.UnloadBundle("Config");
		string url = null;
		if (Application.platform == RuntimePlatform.Android) {
			url = Application.streamingAssetsPath + "/" + AESEncryptor.GetMd5("Config") + ".bhp";
		}else{
			url = "file:///" + Application.streamingAssetsPath + "/" + AESEncryptor.GetMd5("Config") + ".bhp";
		}
		WWW www = new WWW(url);
		yield return www;
		if (www.assetBundle == null || www.error != null){
			callback(null, www.error);
		}
		TextAsset configAsset = www.assetBundle.LoadAsset ("BundleConfig") as TextAsset;
		if (configAsset == null) {
			callback(null, "BundleConfig.json not found");
		}
		string configContent = AESEncryptor.Decrypt(configAsset.text);
		var d = JsonMapper.ToObject(configContent);
		string versionCode = (string)d["versionCode"];
		www.assetBundle.Unload(true);
		callback(versionCode, null);
	}

	public delegate void UpdateProgressCallback(int index, int count);
	public delegate void UpdateResultCallback(string errorMsg);

	public static void UpdateToLatestVersion(string url, UpdateProgressCallback progressCallback, UpdateResultCallback resultCallback, MonoBehaviour context){
		CheckVersion(url, delegate(bool isLatestVersion, string errorMsg) {
			if (isLatestVersion){
				progressCallback(0, 0);
				resultCallback(errorMsg);
				if (currentWWW != null){
					currentWWW.Dispose();
					currentWWW = null;
				}
			}else{
				context.StartCoroutine (GetPackageBundleVersion(delegate(string version, string error) {
					if (error != null){
						resultCallback(error);
						if (currentWWW != null){
							currentWWW.Dispose();
							currentWWW = null;
						}
						Debug.Log("Check Package Bundle Version error :" + error);
						return;
					}
					Debug.Log("packageVersion = " + version);
					int packageVersionIndex = versionCodes.IndexOf(version);
					Debug.Log("packageVersionIndex = " + packageVersionIndex);
					int localVersionIndex = versionCodes.IndexOf(localVersionInfo.versionCode);
					Debug.Log("localVersionIndex = " + localVersionIndex);
					if (packageVersionIndex > localVersionIndex){
						Debug.Log("new package installed error");
						resultCallback("new package installed error");
						if (currentWWW != null){
							currentWWW.Dispose();
							currentWWW = null;
						}
					}else{
						context.StartCoroutine(DoUpdateToLatestVersion(url, progressCallback, resultCallback, context));
					}
				}));	
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
				if (currentWWW != null){
					currentWWW.Dispose();
					currentWWW = null;
				}
				yield break;
			}
			if (text != null){
				JsonData jd = JsonMapper.ToObject(text);
				VersionInfo v = new VersionInfo();
				v.Encode(jd);
				if (v.newPackage) {
					resultCallback("need install new package");
					if (currentWWW != null){
						currentWWW.Dispose();
						currentWWW = null;
					}
					yield break;
				}
				if (i == versionCodes.Count - 1 && v.whiteList != null) {
					string encryptStr = PlayerPrefs.GetString("CachedUserAccount");
					if (encryptStr != null && encryptStr != "") {
						string cacheStr = AESEncryptor.Decrypt(encryptStr);
						if (cacheStr != null && cacheStr != "") {
							string beginSymbol = "{username = \"";
							int beginIndex = cacheStr.IndexOf(beginSymbol) + beginSymbol.Length;
							string endSymbol = "\",";
							int endIndex = cacheStr.IndexOf(endSymbol, beginIndex);
							string userName = cacheStr.Substring(beginIndex, endIndex);
							if (v.whiteList.Contains(userName)){
								continue;
							}
						}
					}
				}
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
		}

		int progressIndex = 0;
		foreach (var i in bundleInfos) {
			BundleInfo b = i.Value;
			BundleInfo localVersionBundle = localVersionInfo.GetBundleInfoByName(b.name);
			if (localVersionBundle != null && localVersionBundle.md5 != null && b.md5 != null && localVersionBundle.md5 == b.md5){
				progressIndex += 1; 
				progressCallback(progressIndex, bundleInfos.Count);
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
				if (currentWWW != null){
					currentWWW.Dispose();
					currentWWW = null;
				}
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
						if (currentWWW != null){
							currentWWW.Dispose();
							currentWWW = null;
						}
						yield break;
					}
				}
				try{
					var f = File.Open(kDownloadPath + "/" + AESEncryptor.GetMd5(b.name) + ".bhp", FileMode.OpenOrCreate, FileAccess.Write);
					f.Write(bytes, 0, bytes.Length);
					f.Close();
				}catch (Exception e){
					resultCallback(b.name + " write error" + e.Message);
					if (currentWWW != null){
						currentWWW.Dispose();
						currentWWW = null;
					}
					yield break;
				}
			}
			progressIndex += 1; 
			progressCallback(progressIndex, bundleInfos.Count);
		}
		InitLocalVersionInfo();
		resultCallback (null);
		if (currentWWW != null){
			currentWWW.Dispose();
			currentWWW = null;
		}
	}
	private delegate void HandleFinishDownload(WWW www);
	private static IEnumerator DownloadVersionBundle(string url, string versionCode, string bundleName, HandleFinishDownload callback){
		string target = null;
		if (Application.platform == RuntimePlatform.Android) {
			target = "android";
		} else if (Application.platform == RuntimePlatform.IPhonePlayer) {
			target = "ios";
		}
		string downloadUrl = url + "/" + versionCode + "_" + target + "_" + bundleName + ".bhp";
		Debug.Log("DownloadVersionBundle : " + downloadUrl);
		currentWWW = new WWW (downloadUrl);
		yield return currentWWW;
		if (callback != null) {
			callback(currentWWW);		
		}
	}
	private static IEnumerator DownloadVersionFile(string url, HandleFinishDownload callback){
		string downloadUrl = url + "/versions.json";
		Debug.Log("DownloadVersionFile : " + downloadUrl);
		WWW versionWWW = new WWW (downloadUrl);
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
		string downloadUrl = url + "/" + versionCode  + "_" + target + "_Config.bhp";
		Debug.Log("DownloadBundleConfigFile : " + downloadUrl);
		WWW versionWWW = new WWW (downloadUrl);
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
		string fullname = VersionManager.GetLocalVersion () + "_" + target + "_" + name + ".bhp";
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
