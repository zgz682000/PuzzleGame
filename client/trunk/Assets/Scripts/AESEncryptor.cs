using System;
using System.Collections;
using System.IO;
using System.Security.Cryptography;
using System.Text;

public class AESEncryptor
{
	public const string kAESEncryptorCommonKey = "e4da644248e1561ce0864b838f17161c";
	public static byte[] Encrypt(byte[] toEncryptArray, string key = kAESEncryptorCommonKey)
	{
		byte[] keyArray = UTF8Encoding.UTF8.GetBytes(key);
		RijndaelManaged rDel = new RijndaelManaged();
		rDel.Key = keyArray;
		rDel.Mode = CipherMode.ECB;
		rDel.Padding = PaddingMode.PKCS7;
		ICryptoTransform cTransform = rDel.CreateEncryptor();
		byte[] resultArray = cTransform.TransformFinalBlock(toEncryptArray, 0, toEncryptArray.Length);
		return resultArray;
	}

	public static byte[] Decrypt(byte[] toEncryptArray, string key = kAESEncryptorCommonKey)
	{
		byte[] keyArray = UTF8Encoding.UTF8.GetBytes(key);
		RijndaelManaged rDel = new RijndaelManaged();
		rDel.Key = keyArray;
		rDel.Mode = CipherMode.ECB;
		rDel.Padding = PaddingMode.PKCS7;
		ICryptoTransform cTransform = rDel.CreateDecryptor();
		byte[] resultArray = cTransform.TransformFinalBlock(toEncryptArray, 0, toEncryptArray.Length);
		return resultArray;
	}


	public static string Encrypt(string text, string key = kAESEncryptorCommonKey){
		byte[] data1 = UTF8Encoding.UTF8.GetBytes(text);
		byte[] data2 = Encrypt (data1, key);
		string ret = Convert.ToBase64String (data2);
		return ret;
	}

	public static string Decrypt(string text, string key = kAESEncryptorCommonKey){
		byte[] data1 = Convert.FromBase64String(text);
		byte[] data2 = Decrypt (data1, key);
		string ret = UTF8Encoding.UTF8.GetString (data2);
		return ret;
	}

	public static string GetMd5(byte[] data){
		MD5 md5 = new MD5CryptoServiceProvider();
		byte[] result = md5.ComputeHash(data);
		string fileMD5 = BitConverter.ToString (result).Replace ("-", "").ToLower();
		return fileMD5;
	}
	public static string GetMd5(string str){
		byte[] data = UTF8Encoding.UTF8.GetBytes (str);
		return GetMd5 (data);
	}
}
