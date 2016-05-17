using UnityEngine;
using System.Collections.Generic;
using System.Collections;
using UnityEditor;
using System;
using System.IO;
using System.Text;
using System.Net;
using ICSharpCode.SharpZipLib.Zip;
using ICSharpCode.SharpZipLib.Core;
using ICSharpCode.SharpZipLib.Zip.Compression.Streams;

public class BuildInvoke {

	static string projectName = "card";
	static string targetDir = Application.dataPath + "/../../../build";
	static List<string> deleteBundlePathes = null;

	[MenuItem ("Custom/Build/Test")]
	public static void Test(){
		BuildPipeline.BuildAssetBundles (Application.dataPath + "/../../build/patchers", BuildAssetBundleOptions.None, BuildTarget.iOS);
	}

	[MenuItem ("Custom/Build/Build Android Player")]
	public static void BuildAndroidPlayer(){
		GenericBuild("android");
	}

	[MenuItem ("Custom/Build/Build iOS Player")]
	public static void BuildIOSPlayer(){
		GenericBuild("ios");
	}
	[MenuItem ("Custom/Build/Upload Versions File")]
	public static void UploadVersionsFile(){
		UploadFile(targetDir + "/patchers/versions.json");
	}

	// [MenuItem ("Custom/Build/Build Lua Src")]
	// public static void BuildLuaSource(){
	// 	DoBuildAssetBundle(List<UnityEngine.Object> assetsList, string bundleName, string target);
	// }

	private static string[] FindEnabledEditorScenes() {
		List<string> EditorScenes = new List<string>();
		foreach(EditorBuildSettingsScene scene in EditorBuildSettings.scenes) {
			if (!scene.enabled) continue;
			EditorScenes.Add(scene.path);
		}
		return EditorScenes.ToArray();
	}
	
	private static void GenericBuild(string target)
	{	

		BundleInfo.bundleTarget = target;

		if (deleteBundlePathes == null) {
			deleteBundlePathes = new List<string>();		
		}
		deleteBundlePathes.Clear ();

		BuildAssetBundle (target);

		string tempPath = targetDir + "/temp";
		if (Directory.Exists (tempPath)) {
			Directory.Delete(tempPath, true);	
		}
		Directory.CreateDirectory (tempPath);

		VersionInfo localVersion = VersionManager.localVersionInfo;
		foreach (BundleInfo b in localVersion.bundleInfos) {
			Walk (Application.dataPath + "/" + b.path, delegate (string path){
				string name = Path.GetFileName(path);
				if (b.excludes != null && b.excludes.Contains(name)){
					return false;
				}
				if (!Path.HasExtension(path)){
					return true;
				}
				if (Path.GetExtension(path) != b.type){
					return true;
				}
				string relativePath = path.Substring(path.IndexOf("/Assets/") + 8); 
				string newName = string.Join("#",relativePath.Split('/'));
				string newPath = tempPath + "/" + newName;
				File.Move(path, newPath);
				return true;
			});

			string bundlePath = targetDir + "/patchers/" + VersionManager.GetBundleFullName(b.name, target);
			string bundleNewPath = Application.streamingAssetsPath + "/" + AESEncryptor.GetMd5(b.name) + ".stp";
			File.Copy(bundlePath, bundleNewPath);
		}

		AssetDatabase.Refresh();

		BuildTarget bt = BuildTarget.WebPlayer;
		string packageName = null;
		switch (target) {
		case "android":
			bt = BuildTarget.Android;
			packageName = "card_" + localVersion.versionCode + ".apk";
			break;
		case "ios":
			bt = BuildTarget.iOS;
			packageName = "card";
			break;
		default:
			break;
		}
		EditorUserBuildSettings.SwitchActiveBuildTarget(bt);
		string[] scenes = new string[]{
			"Assets/Resources/Scenes/CoverScene.unity"
		};
		string td = targetDir + "/packages/" + packageName;
		string res = BuildPipeline.BuildPlayer(scenes,td,bt,BuildOptions.None);

		Walk (tempPath, delegate (string path){
			string name = Path.GetFileName(path);
			string relativePath = string.Join("/", name.Split('#'));
			string fullPath = Application.dataPath + "/" + relativePath;
			File.Move(path, fullPath);
			return true;
		});
		
		foreach (BundleInfo b in localVersion.bundleInfos) {
			string bundleNewPath = Application.streamingAssetsPath + "/" + AESEncryptor.GetMd5(b.name) + ".stp";
			File.Delete(bundleNewPath);
		}
		AssetDatabase.Refresh();

		foreach (string db in deleteBundlePathes) {
			string bundleNewPath = targetDir + "/patchers/" + VersionManager.GetBundleFullName(db, target);
			File.Delete(bundleNewPath);		
		}

		if (res.Length > 0) {
			throw new Exception("BuildPlayer failure: " + res);
		}


		

		if (target == "ios") {
			Directory.Delete (targetDir + "/projects/ios/Data", true);
			Directory.Delete (targetDir + "/projects/ios/Classes", true);	
			Directory.Move(targetDir + "/packages/card/Data", targetDir + "/projects/ios/Data");
			Directory.Move(targetDir + "/packages/card/Classes", targetDir + "/projects/ios/Classes");
			Directory.Delete(targetDir + "/packages/card", true);
		} else if (target == "android") {
			Directory.Delete (targetDir + "/projects/android/assets", true);
			Directory.CreateDirectory(targetDir + "/projects/android/assets");

			ZipFile zf = new ZipFile(td);
			foreach(ZipEntry ze in zf){
				if (ze.Name.Contains("assets/")){
					string path = targetDir + "/projects/android/" + ze.Name;
					if (!Directory.Exists(Path.GetDirectoryName(path))){
						string[] pathComps = Path.GetDirectoryName(ze.Name).Split('/');
						string tempPath1 = targetDir + "/projects/android";
						foreach(string pathComp in pathComps){
							tempPath1 += "/" + pathComp;
							if (!Directory.Exists(tempPath1)){
								Directory.CreateDirectory(tempPath1);
							}
						}
					}
					var zs = zf.GetInputStream(ze);
					FileStream fs = File.Open(path, FileMode.OpenOrCreate, FileAccess.Write);
					
					
					byte[] zd = new byte[ze.CompressedSize];
					int r = zs.Read(zd, 0, (int)ze.CompressedSize);
					fs.Write(zd, 0, r);
					
					zs.Close();
					fs.Close();
				}
			}
		}

		 Walk (targetDir + "/patchers", delegate (string path) {
		 	if (Path.GetExtension(path) == ".stp"){
		 		string fileVersionCode = Path.GetFileName(path).Split('_')[0];
		 		string fileTarget = Path.GetFileName(path).Split('_')[1];
		 		if(fileVersionCode == localVersion.versionCode && fileTarget == target){
		 			UploadFile(path);
		 		}
		 	}
		 	return true;
		 });
	}
	public static void UploadFile(string filePath){
		FileInfo fileInfo = new FileInfo (filePath);
		FtpWebRequest reqFTP = (FtpWebRequest)FtpWebRequest.Create(new Uri("ftp://123.56.96.158:2333/" + fileInfo.Name));
		reqFTP.Credentials = new NetworkCredential("zhangguozhi", "789/*-");
		reqFTP.KeepAlive = false;
		reqFTP.Method = WebRequestMethods.Ftp.UploadFile;
		reqFTP.UseBinary = true;  
		reqFTP.ContentLength = fileInfo.Length;
		FileStream fs = fileInfo.OpenRead();  
		byte[] fd = new byte[fs.Length];
		fs.Read (fd, 0, (int)fs.Length);
		fs.Close ();
		Stream strm = reqFTP.GetRequestStream();
		strm.Write(fd, 0, fd.Length);
		strm.Close ();
	}
	
	public static void CleanBuild(){
		if (AssetBundleManager.assetsMap != null) {
			AssetBundleManager.assetsMap.Clear ();
		}
	}
	public static void BuildAssetBundle(string target){
		CleanBuild ();
		string tempPath = Application.streamingAssetsPath + "/temp";
		if (Directory.Exists (tempPath)) {
			Directory.Delete(tempPath, true);	
		}
		Directory.CreateDirectory (tempPath);
		AssetDatabase.Refresh();
		VersionManager.InitLocalVersionInfo ();
		AssetBundleManager.InitAssetsMap ();
		AssetBundleManager.assetsMap.Clear ();
		VersionInfo localVersion = VersionManager.localVersionInfo;
		VersionManager.InitVersionCodes (target);
		foreach (BundleInfo b in localVersion.bundleInfos) {

			if (b.name == "Config"){
				VersionManager.SaveLocalVersionInfo (Application.dataPath + "/Resources/Config/BundleConfig.json");
				AssetBundleManager.SaveAssetsMap (Application.dataPath + "/Resources/Config/AssetsConfig.json");
				AssetDatabase.Refresh();
			}

			List<string> pathList = new List<string> ();
			List<UnityEngine.Object> assetsList = new List<UnityEngine.Object> ();
			Walk (Application.dataPath + "/" + b.path, delegate (string path){
				string name = Path.GetFileName(path);
				if (b.excludes != null && b.excludes.Contains(name)){
					return false;
				}
				if (!Path.HasExtension(path)){
					return true;
				}
				if (Path.GetExtension(path) != b.type){
					return true;
				}
				string newPath = path;
				if (b.type == ".lua"){
					newPath = tempPath + "/" + Path.GetFileName(path) + ".txt";
					StreamReader luaReader = File.OpenText(path);
					string luaContent = luaReader.ReadToEnd();
					luaReader.Close();
					string luaContentEncrypt = AESEncryptor.Encrypt(luaContent, AESEncryptor.kAESEncryptorCommonKey);
					FileStream luaFileW = File.Open(newPath, FileMode.OpenOrCreate, FileAccess.Write);
					byte[] luaContentEncryptData = UTF8Encoding.UTF8.GetBytes(luaContentEncrypt);
					luaFileW.Write(luaContentEncryptData, 0, luaContentEncryptData.Length);
					luaFileW.Close();
				}else if(b.type == ".json"){
					newPath = tempPath + "/" + Path.GetFileName(path);
//					if (name == "BundleConfig.json") {
//						VersionManager.SaveLocalVersionInfo (newPath);
//						AssetBundleManager.SaveAssetsMap (tempPath + "/AssetsConfig.json");
//						pathList.Add("Assets/StreamingAssets/temp/AssetsConfig.json");
//					}else{
						StreamReader jsonReader = File.OpenText(path);
						string jsonContent = jsonReader.ReadToEnd();
						jsonReader.Close();
						string jsonContentEncrypt = AESEncryptor.Encrypt(jsonContent, AESEncryptor.kAESEncryptorCommonKey);
						FileStream jsonFileW = File.Open(newPath, FileMode.OpenOrCreate, FileAccess.Write);
						byte[] jsonContentEncryptData = UTF8Encoding.UTF8.GetBytes(jsonContentEncrypt);
						jsonFileW.Write(jsonContentEncryptData, 0, jsonContentEncryptData.Length);
						jsonFileW.Close();
//					}
				}
				string relativePath = newPath.Substring(newPath.IndexOf("/Assets/") + 1); 
				pathList.Add(relativePath);

				if(relativePath.IndexOf("/Resources/") != -1){
					Debug.Log(Path.GetFileNameWithoutExtension(newPath));
					AssetBundleManager.assetsMap.Add(Path.GetFileNameWithoutExtension(newPath), b.name);
				}
				return true;
			});
			AssetDatabase.Refresh();

			bool buildRet = false;
			
			if (b.type == ".unity"){
				buildRet = DoBuildSceneBundle(pathList, b.name, target);
			}else{
				foreach (string path in pathList) {
					UnityEngine.Object asset = AssetDatabase.LoadMainAssetAtPath(path);
					if (asset != null){
						assetsList.Add(asset);
					}
				}
				buildRet = DoBuildAssetBundle (assetsList, b.name, target);
			}
			if (buildRet){
				string buildPath = targetDir + "/patchers/" + b.name + ".stp";

				if (File.Exists(buildPath)){
					string newPath = targetDir + "/patchers/" + VersionManager.GetBundleFullName(b.name, target);
					FileStream fread = File.OpenRead(buildPath);
					byte[] data = new byte[fread.Length];
					fread.Read(data, 0, (int)fread.Length);
					string md5 = AESEncryptor.GetMd5(data);
					fread.Close();
					if (b.md5 != null && !File.Exists(newPath) && b.md5 == md5){
						deleteBundlePathes.Add(b.name);
					}
					b.md5 = md5;
					if (File.Exists(newPath)){
						File.Delete(newPath);
					}
					File.Move(buildPath, newPath);
				}
			}
		}

		if (Directory.Exists (tempPath)) {
			Directory.Delete(tempPath, true);	
		}

		AssetDatabase.Refresh();

		VersionManager.SaveVersionCodes (target);

		CleanBuild ();
	}

	private delegate bool WalkHandle(string path);
	private static void Walk(string path, WalkHandle handler){
		var entities = Directory.GetFileSystemEntries(path);
		foreach (string e in entities){
			if (!handler(e)){
				continue;
			}
			if (!Path.HasExtension(e)){
				Walk(e, handler);
			}
		}
	}
	private static bool DoBuildSceneBundle(List<string> levelList, string bundleName, string target){
		string buildPath = targetDir + "/patchers/" + bundleName + ".stp";
		BuildTarget bt = BuildTarget.WebPlayer;
		switch (target) {
		case "android":
			bt = BuildTarget.Android;
			break;
		case "ios":
			bt = BuildTarget.iOS;
			break;
		default:
			break;
		}
		string ret = BuildPipeline.BuildStreamedSceneAssetBundle(levelList.ToArray(), buildPath, bt);
		if (ret == "") {
			Debug.Log("build success " + bundleName);
			return true;		
		} else {
			Debug.Log("build fail " + bundleName);
			return false;	
		}
	}
	private static bool DoBuildAssetBundle(List<UnityEngine.Object> assetsList, string bundleName, string target){
		string buildPath = targetDir + "/patchers/" + bundleName + ".stp";
		BuildAssetBundleOptions options = BuildAssetBundleOptions.CollectDependencies |
			BuildAssetBundleOptions.CompleteAssets | BuildAssetBundleOptions.DeterministicAssetBundle;
		BuildTarget bt = BuildTarget.WebPlayer;
		switch (target) {
		case "android":
			bt = BuildTarget.Android;
			break;
		case "ios":
			bt = BuildTarget.iOS;
			break;
		default:
			break;
		}
		if (BuildPipeline.BuildAssetBundle (null, assetsList.ToArray (), buildPath, options, bt)) {
			Debug.Log("build success " + bundleName);
			return true;
		} else {
			Debug.Log("build fail " + bundleName);
			return false;
		}
	}
}
