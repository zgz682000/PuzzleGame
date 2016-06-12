
Constant = {

	baseRemoveScore = function (n) --基本消除时，每个水果得分
		return 10 * (n - 1);
	end,

	comboScore = function (baseScore, combo) --有combo时，每个消除的翻倍得分
		return baseScore * combo;
	end,

	sameColorRemoveScore = 60, --同色消时，每个水果得分

	allRemoveScore = 60, --全屏消，每个水果得分

	bombRemoveScore = function (m) --其他爆炸时，每个水果得分
		return 10 * (m - 1);
	end
}
