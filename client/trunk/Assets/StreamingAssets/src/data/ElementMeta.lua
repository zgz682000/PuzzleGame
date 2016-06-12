ElementMeta = {
	[10001] = {
		metaId = 10001,
		type = "grid",
		name = "grid_normal",
		desc = "普通六边形格"
	},
	[10002] = {
		metaId = 10002,
		type = "grid",
		name = "grid_generator",
		desc = "新水果生成格"
	},

	[20001] = {
		metaId = 20001,
		type = "cell",
		color = "red",
		name = "cell_red_normal",
		desc = "普通草莓"
	},

	[20002] = {
		metaId = 20002,
		type = "cell",
		color = "orange",
		name = "cell_orange_normal",
		desc = "普通橘子"
	},

	[20003] = {
		metaId = 20003,
		type = "cell",
		color = "green",
		name = "cell_green_normal",
		desc = "普通西瓜"
	},

	[20004] = {
		metaId = 20004,
		type = "cell",
		color = "blue",
		name = "cell_blue_normal",
		desc = "普通蓝莓"
	},

	[20005] = {
		metaId = 20005,
		type = "cell",
		color = "purple",
		name = "cell_purple_normal",
		desc = "普通火龙果"
	},

	

	[20011] = {
		metaId = 20011,
		type = "cell",
		color = "red",
		name = "cell_red_vBomb",
		desc = "草莓纵向炸弹"
	},

	[20012] = {
		metaId = 20012,
		type = "cell",
		color = "orange",
		name = "cell_orange_vBomb",
		desc = "橘子纵向炸弹"
	},

	[20013] = {
		metaId = 20013,
		type = "cell",
		color = "green",
		name = "cell_green_vBomb",
		desc = "西瓜纵向炸弹"
	},

	[20014] = {
		metaId = 20014,
		type = "cell",
		color = "blue",
		name = "cell_blue_vBomb",
		desc = "蓝莓纵向炸弹"
	},

	[20015] = {
		metaId = 20015,
		type = "cell",
		color = "purple",
		name = "cell_purple_vBomb",
		desc = "火龙果纵向炸弹"
	},
	[20021] = {
		metaId = 20021,
		type = "cell",
		color = "red",
		name = "cell_red_lBomb",
		desc = "草莓左斜线炸弹"
	},

	[20022] = {
		metaId = 20022,
		type = "cell",
		color = "orange",
		name = "cell_orange_lBomb",
		desc = "橘子左斜线炸弹"
	},

	[20023] = {
		metaId = 20023,
		type = "cell",
		color = "green",
		name = "cell_green_lBomb",
		desc = "西瓜左斜线炸弹"
	},

	[20024] = {
		metaId = 20024,
		type = "cell",
		color = "blue",
		name = "cell_blue_lBomb",
		desc = "蓝莓左斜线炸弹"
	},

	[20025] = {
		metaId = 20025,
		type = "cell",
		color = "purple",
		name = "cell_purple_lBomb",
		desc = "火龙果左斜线炸弹"
	},
	[20031] = {
		metaId = 20031,
		type = "cell",
		color = "red",
		name = "cell_red_rBomb",
		desc = "草莓右斜线炸弹"
	},

	[20032] = {
		metaId = 20032,
		type = "cell",
		color = "orange",
		name = "cell_orange_rBomb",
		desc = "橘子右斜线炸弹"
	},

	[20033] = {
		metaId = 20033,
		type = "cell",
		color = "green",
		name = "cell_green_rBomb",
		desc = "西瓜右斜线炸弹"
	},

	[20034] = {
		metaId = 20034,
		type = "cell",
		color = "blue",
		name = "cell_blue_rBomb",
		desc = "蓝莓右斜线炸弹"
	},

	[20035] = {
		metaId = 20035,
		type = "cell",
		color = "purple",
		name = "cell_purple_rBomb",
		desc = "火龙果右斜线炸弹"
	},
	[20041] = {
		metaId = 20041,
		type = "cell",
		color = "red",
		name = "cell_red_aBomb",
		desc = "草莓面炸弹"
	},

	[20042] = {
		metaId = 20042,
		type = "cell",
		color = "orange",
		name = "cell_orange_aBomb",
		desc = "橘子面炸弹"
	},

	[20043] = {
		metaId = 20043,
		type = "cell",
		color = "green",
		name = "cell_green_aBomb",
		desc = "西瓜面炸弹"
	},

	[20044] = {
		metaId = 20044,
		type = "cell",
		color = "blue",
		name = "cell_blue_aBomb",
		desc = "蓝莓面炸弹"
	},

	[20045] = {
		metaId = 20045,
		type = "cell",
		color = "purple",
		name = "cell_purple_aBomb",
		desc = "火龙果面炸弹"
	},
	
	[20056] = {
		metaId = 20006,
		type = "cell",
		color = "mix",
		name = "cell_mix",
		desc = "同色消"
	},

	[30001] = {
		metaId = 30001,
		type = "block",
		name = "block_tree_1",
		desc = "1级树桩",
		cell_containable = false,
		cell_moveable = false,
		cell_removeable = false,
		cell_group_checkable = false,
		self_remove_decrease = false,
		self_bomb_decrease = true,
		side_remove_decrease = true,
		side_bomb_decrease = true,
	},

	[30002] = {
		metaId = 30002,
		type = "block",
		name = "block_tree_2",
		desc = "2级树桩",
		cell_containable = false,
		cell_moveable = false,
		cell_removeable = false,
		cell_group_checkable = false,
		self_remove_decrease = false,
		self_bomb_decrease = true,
		side_remove_decrease = true,
		side_bomb_decrease = true,
		decrease_to = 30001
	},


	[30003] = {
		metaId = 30003,
		type = "block",
		name = "block_cirrus_1",
		desc = "1级藤蔓",
		cell_containable = true,
		cell_moveable = false,
		cell_removeable = false,
		cell_group_checkable = true,
		self_remove_decrease = true,
		self_bomb_decrease = true,
		side_remove_decrease = true,
		side_bomb_decrease = true,
	},


	[30004] = {
		metaId = 30004,
		type = "block",
		name = "block_cirrus_2",
		desc = "2级藤蔓",
		cell_containable = true,
		cell_moveable = false,
		cell_removeable = false,
		cell_group_checkable = true,
		self_remove_decrease = true,
		self_bomb_decrease = true,
		side_remove_decrease = true,
		side_bomb_decrease = true,
		decrease_to = 30003
	},

	[30005] = {
		metaId = 30005,
		type = "block",
		name = "block_cage",
		desc = "牢笼",
		cell_containable = true,
		cell_moveable = false,
		cell_removeable = false,
		cell_group_checkable = true,
		self_remove_decrease = true,
		self_bomb_decrease = true,
		side_remove_decrease = false,
		side_bomb_decrease = false,
	},

	[30006] = {
		metaId = 30006,
		type = "block",
		name = "block_net_1",
		desc = "1级蜘蛛网",
		cell_containable = true,
		cell_moveable = false,
		cell_removeable = false,
		cell_group_checkable = true,
		self_remove_decrease = true,
		self_bomb_decrease = true,
		side_remove_decrease = false,
		side_bomb_decrease = false,
	},

	[30007] = {
		metaId = 30007,
		type = "block",
		name = "block_net_2",
		desc = "2级蜘蛛网",
		cell_containable = true,
		cell_moveable = false,
		cell_removeable = false,
		cell_group_checkable = true,
		self_remove_decrease = true,
		self_bomb_decrease = true,
		side_remove_decrease = false,
		side_bomb_decrease = false,
		decrease_to = 30006
	},

	[30008] = {
		metaId = 30008,
		type = "block",
		name = "block_mud",
		desc = "泥巴",
		cell_containable = false,
		cell_moveable = false,
		cell_removeable = false,
		cell_group_checkable = false,
		self_remove_decrease = false,
		self_bomb_decrease = true,
		side_remove_decrease = true,
		side_bomb_decrease = true,
		round_step = "BlockGrowStep"
	},

	[30009] = {
		metaId = 30009,
		type = "block",
		name = "block_wisteria",
		desc = "紫藤",
		cell_containable = true,
		cell_moveable = false,
		cell_removeable = false,
		cell_group_checkable = true,
		self_remove_decrease = true,
		self_bomb_decrease = true,
		side_remove_decrease = true,
		side_bomb_decrease = true,
		round_step = "BlockGrowStep"
	},

	[30010] = {
		metaId = 30010,
		type = "block",
		name = "block_bug",
		desc = "甲虫",
		cell_containable = true,
		cell_moveable = false,
		cell_removeable = false,
		cell_group_checkable = false,
		self_remove_decrease = false,
		self_bomb_decrease = true,
		side_remove_decrease = true,
		side_bomb_decrease = true,
		round_step = "BlockMoveStep"
	},

	[30011] = {
		metaId = 30011,
		type = "block",
		name = "block_stone",
		desc = "石头",
		cell_containable = false,
		cell_moveable = false,
		cell_removeable = false,
		cell_group_checkable = false,
		self_remove_decrease = false,
		self_bomb_decrease = false,
		side_remove_decrease = false,
		side_bomb_decrease = false,
		prevent_line_bomb = true
	},

	[30012] = {
		metaId = 30012,
		type = "block",
		name = "block_sand_1",
		desc = "1级沙块",
		cell_containable = true,
		cell_moveable = true,
		cell_removeable = true,
		cell_group_checkable = true,
		self_remove_decrease = true,
		self_bomb_decrease = true,
		side_remove_decrease = false,
		side_bomb_decrease = false,
	},

	[30013] = {
		metaId = 30013,
		type = "block",
		name = "block_sand_2",
		desc = "2级沙块",
		cell_containable = true,
		cell_moveable = true,
		cell_removeable = true,
		cell_group_checkable = true,
		self_remove_decrease = true,
		self_bomb_decrease = true,
		side_remove_decrease = false,
		side_bomb_decrease = false,
		decrease_to = 30012,
		render_order = 1
	},

	[30014] = {
		metaId = 30014,
		type = "block",
		name = "block_wind",
		desc = "龙卷风",
		cell_containable = false,
		cell_moveable = false,
		cell_removeable = false,
		cell_group_checkable = false,
		self_remove_decrease = false,
		self_bomb_decrease = false,
		side_remove_decrease = false,
		side_bomb_decrease = false,
		round_step = "BlockReorderAroundCellsStep",
		auto_decrease = 5
	},

	[40001] = {
		metaId = 40001,
		type = "gate",
		name = "gate_enter",
		desc = "传送门入口"
	},

	[40002] = {
		metaId = 40002,
		type = "gate",
		name = "gate_exit",
		desc = "传送门出口"
	} 
}

LevelTargetTemplates = {
	remove_element = {
		elements = {
			{elementMetaId = "", count = 0},
			{elementMetaId = "", count = 0}
		}
	},

	discover_rune = {
		runes = {
			{runeMetaId = "", grids = {0, 10002, 6007983}},
			{runeMetaId = "", grids = {9003312, 12135663, 1231235}},
		}
	},

	score = {
		score = 1000,
	},

	dispose_mine = {
		round = {1,10,25,28}
	}
}
