
function callNextFrame(func, args)
	local function tick()
		UpdateBeat:Remove(tick);
		func(args);
	end
	UpdateBeat:Add(tick);
end

function createITweenHash(gameObject, callback, ...)
	if callback then
		return iTween.Hash("oncompletetarget", gameObject, "oncomplete", "iTweenCallBack", "oncompleteparams", callback, ...);
	else
		return iTween.Hash(...);
	end
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
	if scale then
		obj.transform.localScale=scale;
	end
	if position then
		obj.transform.localPosition=position;
	end
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

function PZPrint(...)
	if isDebugBuild and Application.isEditor then
		print(...)
	else

	end
end




