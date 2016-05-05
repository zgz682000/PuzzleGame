require "data.Metas"

function callNextFrame(func, args)
	local function tick()
		UpdateBeat:Remove(tick);
		func(args);
	end
	UpdateBeat:Add(tick);
end

function createITweenHash(gameObject, hashParams, callback)
	if callback then
		table.insert(hashParams, "oncompletetarget");
		table.insert(hashParams, gameObject);
		table.insert(hashParams,"oncomplete");
		table.insert(hashParams,"iTweenCallBack");
		table.insert(hashParams,"oncompleteparams");
		table.insert(hashParams,callback);
	end

	return iTween.Hash(unpack(hashParams))
end


local languageResPrefixMap = {
	Chinese = "cn",
	English = "en",
}
function GetText(key)
	resPrefix = languageResPrefixMap[tostring(Application.systemLanguage)];
	require ("data."..resPrefix .. "_text");
	return LocalizedTexts[key] or "";
end

function GetBundleVersion()
	return VersionManager.GetLocalVersion();
end

function ResourcesLoad(path)
	if isDebugBuild then
		return UnityEngine.Resources.Load(path);
	else
		local nameComponents = string.split(path, "/");
		local name = nameComponents[#nameComponents];
		return AssetBundleManager.LoadAssetByName(name);
	end
end
function CreatePrefab(path,position,scale,parent)
	local obj=GameObject.Instantiate(ResourcesLoad(path),Vector3.zero,Quaternion.identity);
		obj.transform:SetParent (parent);
		obj.transform.localScale=scale;
		obj.transform.localPosition=position;
	return obj;
end


function table.find(self, o)
	local ret = nil;
	for k,v in pairs(self) do
		if v == o then
			ret = k;
			break;
		end
	end
	return ret;
end


function PZAssert(exp, msg)
	if not exp then
		if isDebugBuild then
			error(msg);
		else

		end
	end
end






