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
		cell_contain = false,
		cell_moveable = false,
		cell_removeable = false,
		self_remove_decrease = false,
		self_bomb_decrease = false,
		side_remove_decrease = true,
		side_bomb_decrease = false,
		round_trigger = "",
	},

	[30002] = {
		metaId = 30002,
		type = "block",
		name = "block_tree_2",
		desc = "2级树桩",
		cell_contain = false,
		cell_moveable = false,
		cell_removeable = false,
		self_remove_decrease = false,
		self_bomb_decrease = false,
		side_remove_decrease = true,
		side_bomb_decrease = false,
		round_trigger = "",
		decrease_to = 30001
	},

	-- [30002] = {
	-- 	metaId = 30002,
	-- 	type = "block",
	-- 	name = "ice",
	-- 	desc = "冰",
	-- 	cell_contain = true,
	-- 	cell_moveable = true,
	-- 	self_remove_decrease = true,
	-- 	self_bomb_decrease = true,
	-- 	side_remove_decrease = false,
	-- 	side_bomb_decrease = false,
	-- 	round_trigger = "",
	-- },

	-- [30003] = {
	-- 	metaId = 30003,
	-- 	type = "block",
	-- 	name = "cirrus",
	-- 	desc = "藤蔓",
	-- 	cell_contain = true,
	-- 	cell_moveable = false,
	-- 	self_remove_decrease = true,
	-- 	self_bomb_decrease = true
	-- 	side_remove_decrease = false,
	-- 	side_bomb_decrease = false,
	-- 	round_trigger = "",
	-- }
}