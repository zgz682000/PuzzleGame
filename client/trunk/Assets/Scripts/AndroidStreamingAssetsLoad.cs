#if !UNITY_IPHONE || UNITY_EDITOR
using UnityEngine;
using System.Collections;
using System;
using System.Collections.Generic;
using System.IO;
using ICSharpCode.SharpZipLib.Zip;
using ICSharpCode.SharpZipLib.Core;

public class AndroidAssetsZip
{
	ZipFile mZipfile = null;
	
	// 释放资源
	public void Release()
	{
		if (mZipfile != null)
		{
			mZipfile.Close();
			mZipfile = null;
		}
	}
	
	public void Init(string filepath, string password = "")
	{
		try
		{
			mZipfile = new ZipFile(filepath);
			mZipfile.Password = password;
			InitFileList();
		}
		catch (System.Exception e)
		{
			Debug.LogError("AssetZip.init error!" + e.Message + ",StackTrace:" + e.StackTrace);
			return;
		}
	}
	
	Dictionary<string, long> mZipEntrys = new Dictionary<string, long>();
	
	// 初始化文件列表
	void InitFileList()
	{
		// zip包当中的所有文件列表
		IEnumerator itor = mZipfile.GetEnumerator();
		while (itor.MoveNext())
		{
			ZipEntry entry = itor.Current as ZipEntry;
			if (entry.IsFile)
				mZipEntrys.Add(entry.Name, entry.ZipFileIndex);
		}
	}
	
	public Stream FindFileStream(string file)
	{
		long entryIndex = -1;
		if (!mZipEntrys.TryGetValue(file, out entryIndex))
		{
			Debug.LogError(string.Format("file: {0} not find!", file));
			return null;
		}
		
		return mZipfile.GetInputStream(entryIndex);
	}
	
	public void EachAllFile(System.Action<string> fun)
	{
		foreach (KeyValuePair<string, long> itor in mZipEntrys)
			fun(itor.Key);
	}
}


public class AndroidStreamingAssetsLoad
{

	static AndroidAssetsZip ApkFile = null;

    public static void Init()
    {
        if (ApkFile == null)
        {
			ApkFile = new AndroidAssetsZip();
            ApkFile.Init(Application.dataPath);
        }
    }

    public static void Release()
    {
        if (ApkFile != null)
        {
            ApkFile.Release();
            ApkFile = null;

            GC.Collect();
        }
    }

    public static bool GetFile(string file, out string dstfile, out int offset)
    {
        Init();
        ZipFile.PartialInputStream stream = ApkFile.FindFileStream("assets/" + file) as ZipFile.PartialInputStream;
        if (stream == null)
        {
            dstfile = string.Empty;
            offset = 0;
            return false;
        }
        else
        {
			dstfile = Application.dataPath;
            offset = (int)stream.StartPos;
            return true;
        }
    }

    public static Stream GetFile(string file)
    {
        Init();
        return ApkFile.FindFileStream("assets/" + file);
    }

    public static void EachAllFile(System.Action<string> fun)
    {

        Init();
        ApkFile.EachAllFile(
            (string file) => 
            {
                if (file.StartsWith("assets/"))
                    fun(file.Substring(7));
            });
    }
}
#endif