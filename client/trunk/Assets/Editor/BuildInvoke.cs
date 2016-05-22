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
using LitJson;
public class BuildInvoke {
	static List<string> deleteBundlePathes = null;
	static string targetDir{
		get{
			string preDefineAndroid = PlayerSettings.GetScriptingDefineSymbolsForGroup(BuildTargetGroup.Android);
			string suffix = null;
			if (preDefineAndroid.IndexOf("QA_SERVER") != -1){
				suffix = "_QA";
			}else if (preDefineAndroid.IndexOf("ONLINE_SERVER") != -1){
				suffix = "_Online";
			}
			string ret = Application.dataPath + "/../../build" + suffix;
			if (!Directory.Exists(ret)){
				ret = Application.dataPath + "/../../../build" + suffix;
			}

			return ret;
		}
	}
	static string uploadUrl {
		get{
			string preDefineAndroid = PlayerSettings.GetScriptingDefineSymbolsForGroup(BuildTargetGroup.Android);
			if (preDefineAndroid.IndexOf("QA_SERVER") != -1){
				return "ftp://192.168.1.149:2333/card_patcher/";
			}else if (preDefineAndroid.IndexOf("ONLINE_SERVER") != -1){
				return "ftp://123.56.96.158:2333/";
			}
			return null;
		}
	}

	static string envSymbol {
		get{
			string preDefineAndroid = PlayerSettings.GetScriptingDefineSymbolsForGroup(BuildTargetGroup.Android);
			if (preDefineAndroid.IndexOf("QA_SERVER") != -1){
				return "qa";
			}else if (preDefineAndroid.IndexOf("ONLINE_SERVER") != -1){
				return "online";
			}
			return null;
		}
	}

	[MenuItem ("Custom/Build/Test")]
	public static void Test(){
		BuildPipeline.BuildAssetBundles (targetDir + "/accetbundles", BuildAssetBundleOptions.None, BuildTarget.iOS);
	}
	[MenuItem ("Custom/Build/Change Env To QA Server")]
	public static void ChangeEnvToQAServer(){
		string preDefineAndroid = PlayerSettings.GetScriptingDefineSymbolsForGroup(BuildTargetGroup.Android);
		string newDefineAndroid = preDefineAndroid.Replace("ONLINE_SERVER", "QA_SERVER");
		PlayerSettings.SetScriptingDefineSymbolsForGroup(BuildTargetGroup.Android, newDefineAndroid);
		string preDefineIOS = PlayerSettings.GetScriptingDefineSymbolsForGroup(BuildTargetGroup.iOS);
		string newDefineIOS = preDefineIOS.Replace("ONLINE_SERVER", "QA_SERVER");
		PlayerSettings.SetScriptingDefineSymbolsForGroup(BuildTargetGroup.iOS, newDefineIOS);
	}
	[MenuItem ("Custom/Build/Change Env To Online Server")]
	public static void ChangeEnvToOnlineServer(){
		string preDefineAndroid = PlayerSettings.GetScriptingDefineSymbolsForGroup(BuildTargetGroup.Android);
		string newDefineAndroid = preDefineAndroid.Replace("QA_SERVER", "ONLINE_SERVER");
		PlayerSettings.SetScriptingDefineSymbolsForGroup(BuildTargetGroup.Android, newDefineAndroid);
		string preDefineIOS = PlayerSettings.GetScriptingDefineSymbolsForGroup(BuildTargetGroup.iOS);
		string newDefineIOS = preDefineIOS.Replace("QA_SERVER", "ONLINE_SERVER");
		PlayerSettings.SetScriptingDefineSymbolsForGroup(BuildTargetGroup.iOS, newDefineIOS);
	}
	[MenuItem ("Custom/Build/Build Android Player")]
	public static void BuildAndroidPlayer(){
		GenericBuild("android");
	}

	[MenuItem ("Custom/Build/Build iOS Player")]
	public static void BuildIOSPlayer(){
		GenericBuild("ios");
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
			string bundleNewPath = Application.streamingAssetsPath + "/" + AESEncryptor.GetMd5(b.name) + ".bhp";
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
			string bundleNewPath = Application.streamingAssetsPath + "/" + AESEncryptor.GetMd5(b.name) + ".bhp";
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
		 	if (Path.GetExtension(path) == ".bhp"){
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
		FtpWebRequest reqFTP = (FtpWebRequest)FtpWebRequest.Create(new Uri(uploadUrl + fileInfo.Name));
		reqFTP.Credentials = new NetworkCredential("zhangguozhi", "789/*-");
		reqFTP.KeepAlive = false;
		reqFTP.Method = WebRequestMethods.Ftp.UploadFile;
		reqFTP.UseBinary = true;  
		reqFTP.ContentLength = fileInfo.Length;
		FileStream fs = fileInfo.OpenRead();  


		Stream strm = reqFTP.GetRequestStream();
		int buffLength = 2048;  
		byte[] buff = new byte[buffLength]; 
		int contentLen = fs.Read(buff, 0, buffLength); 
		while (contentLen != 0)  
		{  
			strm.Write(buff, 0, contentLen);  
			contentLen = fs.Read(buff, 0, buffLength);  
		}
		strm.Close();  
		fs.Close();
	}

	public static void BuildAssetBundle(string target){
		string tempPath = Application.streamingAssetsPath + "/temp";
		if (Directory.Exists (tempPath)) {
			Directory.Delete(tempPath, true);	
		}
		Directory.CreateDirectory (tempPath);
		AssetDatabase.Refresh();

		string versionsFileContent = File.ReadAllText(targetDir + "/../configs/versions.json");
		if (versionsFileContent == null) {
			Debug.LogError ("versions.json file error");
			return;
		}
		string bundlesFileContent = File.ReadAllText (targetDir + "/../configs/bundles.json"); 
		if (bundlesFileContent == null) {
			Debug.LogError ("bundls.json file error");
			return;
		}
		var versionFileObj = JsonMapper.ToObject (versionsFileContent);
		var lastVersion = (string)versionFileObj [versionFileObj.Count - 1];
		var bundlesFileObj = JsonMapper.ToObject(bundlesFileContent);
		VersionInfo localVersion = new VersionInfo ();
		localVersion.Decode (bundlesFileObj[lastVersion]);


		Dictionary<string, string> assetsMap = new Dictionary<string, string> ();

		foreach (BundleInfo b in localVersion.bundleInfos) {

			if (b.name == "src"){
//				AssetBundleManager.SaveAssetsMap (Application.dataPath + "/Resources/Config/AssetsConfig.json");
				AssetDatabase.Refresh();
			}

			List<string> pathList = new List<string> ();

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
				}
				string relativePath = newPath.Substring(newPath.IndexOf("/Assets/") + 1); 
				pathList.Add(relativePath);

				if(relativePath.IndexOf("/Resources/") != -1){
					Debug.Log(Path.GetFileNameWithoutExtension(newPath));
					assetsMap.Add(Path.GetFileNameWithoutExtension(newPath), b.name);
				}
				return true;
			});


			AssetDatabase.Refresh();

			foreach (string path in pathList) {
				AssetImporter ai = AssetImporter.GetAtPath (path);
				ai.assetBundleName = b.name;
			}
		}

		var buildTarget = BuildTarget.WebPlayer;
		if (target == "ios") {
			buildTarget = BuildTarget.iOS;
		} else if (target == "android") {
			buildTarget = BuildTarget.Android;
		}
		var buildTargetDir = targetDir + "/assertbundles/" + target;
		var buildOption = BuildAssetBundleOptions.DeterministicAssetBundle;
		var buildManifest = BuildPipeline.BuildAssetBundles (buildTargetDir, buildOption, buildTarget);


		List<string> renameBundleNames = new List<string>();

		foreach (BundleInfo b in localVersion.bundleInfos) {
			b.md5 = buildManifest.GetAssetBundleHash (b.name).ToString();
			renameBundleNames.Add (b.name);
		}

		if (bundlesFileObj.Count >= 2) {
			var preVesionInfo = new VersionInfo ();
			preVesionInfo.Decode (bundlesFileObj [bundlesFileObj.Count - 2]);

			foreach (BundleInfo b in localVersion.bundleInfos) {
				var preBundle = preVesionInfo.GetBundleInfoByName (b.name);
				if (preBundle != null && preBundle.md5 == b.md5) {
					renameBundleNames.Remove (b.name);
				}
			}
		}

		foreach (string renameBundleName in renameBundleNames) {
			string newName = localVersion.versionCode + "_" + target + "_" + renameBundleName + ".bgp";
			File.Copy (buildTargetDir + "/" + renameBundleName, targetDir + "/patchers/" + newName);
		}

		var newVersionInfoJsonObj = new JsonData();
		newVersionInfoJsonObj.SetJsonType (JsonType.Object);
		localVersion.Encode (newVersionInfoJsonObj);


		var newVersionInfoContent = JsonMapper.ToJson (newVersionInfoJsonObj);
		var encryptNewVersionInfoContent = AESEncryptor.Encrypt (newVersionInfoContent);
		File.WriteAllText (targetDir + "/patchers/" + localVersion.versionCode + "_BundleConfig.json", encryptNewVersionInfoContent);



		bundlesFileObj [lastVersion] = newVersionInfoJsonObj;
		bundlesFileContent = JsonMapper.ToJson (bundlesFileObj);
		File.WriteAllText (targetDir + "/../configs/bundles.json", bundlesFileContent);


		if (Directory.Exists (tempPath)) {
			Directory.Delete(tempPath, true);	
		}

		AssetDatabase.Refresh();

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
}
