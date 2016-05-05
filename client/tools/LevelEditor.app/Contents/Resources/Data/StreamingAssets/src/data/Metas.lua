
SkillMeta = {
	card_list = {
		card = {
			[4001] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				skill_list = {
					skill = {
						{
							type = "cast",
							target = {
								number = "1",
								force = "enemy",
								selector = "all",
								area_list = {
									area = {
										"hero",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "2",
				role = "0",
				set = "0",
				race = "0",
				cndescription = "对敌方英雄造成2点伤害",
				cnname = "技能1",
				description = "card_4001_desc",
				health = "0",
				type = {
					_text = "hero_skill",
					choose = "false",
				},
				timing_list = {
					timing = {
						"cast",
					},
					off = "cast",
					on = "cast",
				},
				camp = "0",
				quality = "1",
				music = {
				},
				soulbound = "0",
				attack = "0",
				meta = "4001",
				name = "card_4001_name",
			},
			[4002] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				skill_list = {
					skill = {
						{
							type = "cast",
							target = {
								number = "1",
								force = "both",
								selector = "picked",
								area_list = {
									area = {
										"desk",
									},
								},
								card_type = "summoned",
							},
						},
					},
				},
				cost = "2",
				role = "0",
				set = "0",
				race = "0",
				cndescription = "使目标仆从获得嘲讽效果，并且增加1点生命值上限",
				cnname = "技能2",
				description = "card_4002_desc",
				health = "0",
				type = {
					_text = "hero_skill",
					choose = "false",
				},
				timing_list = {
					timing = {
						"cast",
					},
					off = "cast",
					on = "cast",
				},
				camp = "0",
				quality = "1",
				music = {
				},
				soulbound = "0",
				attack = "0",
				meta = "4002",
				name = "card_4002_name",
			},
			[4030] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				skill_list = {
					skill = {
						{
							type = "cast",
							target = {
								number = "1",
								force = "self",
								selector = "all",
								area_list = {
									area = {
										"hero",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "2",
				role = "0",
				set = "0",
				race = "0",
				cndescription = "英雄能力",
				cnname = "变形",
				description = "Hero Power  +1 Attack this turn.  +1 Armor.",
				health = "0",
				type = {
					_text = "hero_skill",
					choose = "false",
				},
				timing_list = {
					timing = {
						"out",
					},
					off = "die",
					on = "out",
				},
				camp = "0",
				quality = "1",
				music = {
				},
				soulbound = "0",
				attack = "0",
				meta = "4030",
				name = "Shapeshift",
			},
		},
	},

}
TargetMeta = {
	target = {
		name = "0",
		number = "0",
		selector = "picked",
		id = "1",
		no_target_cast = "false",
	},

}
HeroMeta = {
	card_list = {
		card = {
			[1] = {
				role = "0",
				set = "0",
				race = "0",
				cndescription = "卡奥",
				cnname = "卡奥",
				description = "card_1_desc",
				health = "30",
				type = "hero",
				camp = "4",
				quality = "1",
				Armor = "0",
				attack = "0",
				meta = "1",
				name = "card_1_name",
				skill_id = "4001",
				pet_id = "2001",
			},
			[2] = {
				role = "0",
				set = "0",
				race = "0",
				cndescription = "奈德",
				cnname = "奈德",
				description = "card_2_desc",
				health = "38",
				type = "hero",
				camp = "1",
				quality = "1",
				Armor = "0",
				attack = "0",
				meta = "2",
				name = "card_2_name",
				skill_id = "4002",
				pet_id = "2002",
			},
		},
	},

}
BuffMeta = {
	buff_list = {
		buff = {
			[2] = {
				enchantment = "false",
				item_list = {
					item = {
						{
							type = "Silence",
							value = "1",
						},
					},
				},
				meta = "2",
				cndescription = "沉默",
				cnname = "沉默",
				name = "Silence",
				only = "false",
				description = "Silence",
				trigger = {
				},
				auras = "false",
			},
			[3] = {
				item_list = {
					item = {
						{
							type = "Freezed",
							value = "1",
						},
					},
				},
				meta = "3",
				cndescription = "冻结行动一回合",
				cnname = "冰冻",
				name = "Freezed",
				only = "true",
				description = "Freezing action force.",
				trigger = {
					round = "3",
					timing = "turn_on",
				},
				auras = "false",
			},
			[101] = {
				item_list = {
					item = {
						{
							type = "Health",
							value = "1",
						},
						{
							type = "Attack",
							value = "1",
						},
					},
				},
				meta = "101",
				cndescription = "生命值+1,攻击力+1",
				cnname = "强化",
				name = "reinforcement",
				only = "false",
				description = "health+1,attack+1",
				auras = "false",
			},
			[102] = {
				item_list = {
					item = {
						{
							type = "Health",
							value = "2",
						},
						{
							type = "Attack",
							value = "2",
						},
					},
				},
				meta = "102",
				cndescription = "生命值+2,攻击力+2",
				cnname = "加固",
				name = "Reinforcement",
				only = "false",
				description = "health+2,attack+2",
				auras = "false",
			},
			[103] = {
				meta = "103",
				cndescription = "选择1名敌对仆从。在你回合开始时，摧毁它。",
				cnname = "腐蚀术",
				name = "Corruption",
				only = "true",
				description = "Choose an enemy minion.   At the start of your turn, destroy it.",
				trigger = {
					round = "2",
					timing = "turn_on",
				},
				auras = "false",
			},
			[104] = {
				item_list = {
					item = {
						{
							type = "UnDefine",
							value = "1",
						},
					},
				},
				meta = "104",
				cndescription = "本回合如果没有死亡，则对所有人造成5点伤害",
				cnname = "炸弹人",
				name = "boom",
				only = "false",
				description = "Choose an enemy minion.   At the start of your turn, destroy it.",
				trigger = {
					round = "0",
					timing = "trun_off",
				},
				auras = "false",
			},
			[105] = {
				item_list = {
					item = {
						{
							func = "set",
							type = "Health",
							value = "1",
						},
					},
				},
				meta = "105",
				cndescription = "将所有仆从的生命值都变为1点。",
				cnname = "平等",
				name = "Equality",
				only = "true",
				description = "Change the Health of ALL minions to 1.",
				auras = "false",
			},
			[106] = {
				item_list = {
					item = {
						{
							type = "Attack",
							value = "1",
						},
					},
				},
				meta = "106",
				cndescription = "攻击力+1",
				cnname = "攻击强化",
				name = "Attack reinforcement",
				only = "false",
				description = "attack+1",
				auras = "true",
			},
			[107] = {
				item_list = {
					item = {
						{
							type = "Health",
							value = "1",
						},
						{
							type = "Taunt",
							value = "1",
						},
					},
				},
				meta = "107",
				cndescription = "生命值+1，嘲讽",
				cnname = "生命强化",
				name = "Life enhancement",
				only = "false",
				description = "health+1",
				auras = "false",
			},
			[108] = {
				item_list = {
					item = {
						{
							type = "Attack",
							value = "1",
						},
					},
				},
				meta = "108",
				cndescription = "回合结束前攻击力加1",
				cnname = "攻击强化",
				name = "Attack reinforcement",
				only = "false",
				description = "attack+1",
				trigger = {
					round = "0",
					timing = "trun_off",
				},
				auras = "false",
			},
			[109] = {
				item_list = {
					item = {
						{
							type = "Attack",
							value = "1",
						},
						{
							type = "FirstHit",
							value = "1",
						},
					},
				},
				meta = "109",
				cndescription = "回合结束前攻击力加1和先攻",
				cnname = "攻击强化",
				name = "Attack reinforcement",
				only = "false",
				description = "attack+1",
				trigger = {
					round = "0",
					timing = "trun_off",
				},
				auras = "false",
			},
			[110] = {
				item_list = {
					item = {
						{
							type = "EqualHeroHealth",
							value = "1",
						},
					},
				},
				meta = "110",
				cndescription = "攻击血量等于英雄生命值",
				cnname = "英雄生命强化",
				only = "true",
				auras = "false",
			},
			[111] = {
				item_list = {
					item = {
						{
							type = "Attack",
							value = "1",
						},
						{
							type = "FirstHit",
							value = "1",
						},
						{
							type = "Lifelink",
							value = "1",
						},
					},
				},
				meta = "111",
				cndescription = "回合结束前攻击力加1和先攻,系命",
				cnname = "攻击强化",
				name = "Attack reinforcement",
				only = "false",
				description = "attack+1",
				trigger = {
					round = "0",
					timing = "trun_off",
				},
				auras = "false",
			},
			[112] = {
				enchantment = "true",
				item_list = {
					item = {
						{
							type = "Attack",
							value = "-6",
						},
					},
				},
				meta = "112",
				cndescription = "目标仆从的攻击力减6",
				cnname = "剥夺战心",
				only = "false",
				auras = "false",
			},
			[113] = {
				item_list = {
					item = {
						{
							type = "Attack",
							value = "2",
						},
					},
				},
				meta = "113",
				cndescription = "回合结束前攻击力加2",
				cnname = "攻击强化",
				name = "Attack reinforcement",
				only = "false",
				description = "attack+2",
				trigger = {
					round = "0",
					timing = "trun_off",
				},
				auras = "false",
			},
			[114] = {
				item_list = {
					item = {
						{
							type = "Fade",
							value = "1",
						},
					},
				},
				meta = "114",
				cndescription = "自己回合结束死亡",
				cnname = "消逝",
				only = "false",
				trigger = {
					round = "0",
					timing = "trun_off",
				},
				auras = "false",
			},
			[115] = {
				enchantment = "true",
				item_list = {
					item = {
						{
							type = "Attack",
							value = "1",
						},
						{
							type = "FirstHit",
							value = "1",
						},
					},
				},
				meta = "115",
				cndescription = "攻击力加1和先攻",
				cnname = "点燃怒火",
				only = "false",
				auras = "false",
			},
			[116] = {
				enchantment = "true",
				item_list = {
					item = {
						{
							type = "Attack",
							value = "2",
						},
						{
							type = "Trample",
							value = "1",
						},
					},
				},
				meta = "116",
				cndescription = "回合结束前攻击力加2和践踏",
				cnname = "狂野冲锋",
				only = "false",
				trigger = {
					round = "0",
					timing = "trun_off",
				},
				auras = "false",
			},
			[117] = {
				item_list = {
					item = {
						{
							type = "Attack",
							value = "-1",
						},
					},
				},
				meta = "117",
				cndescription = "回合结束前攻击力减1",
				cnname = "攻击减弱",
				name = "Attack weakened",
				only = "false",
				description = "attack+1",
				trigger = {
					round = "0",
					timing = "trun_off",
				},
				auras = "false",
			},
			[118] = {
				item_list = {
					item = {
						{
							type = "Trench",
							value = "1",
						},
					},
				},
				meta = "118",
				cndescription = "战壕",
				cnname = "战壕",
				only = "false",
				trigger = {
					round = "0",
					timing = "trun_off",
				},
				auras = "false",
			},
		},
	},

}
PetMeta = {
	card_list = {
		card = {
			[2001] = {
				tip_list = {
					tip = {
						"6",
						"1",
						"10",
					},
				},
				skill_list = {
					skill = {
						{
							type = "self_meta",
							effect = {
								state_list = {
									state = {
										"Charge",
										"Trench",
									},
								},
							},
						},
						{
							can_times = "1",
							type = "trigger",
							use_times = "0",
							target = {
								force = "self",
								include_self = "false",
								selector = "all",
								area_list = {
									area = {
										"desk",
									},
								},
								no_target_cast = "true",
							},
						},
						{
							can_times = "1",
							type = "attack",
							use_times = "1",
							target = {
								number = "1",
								force = "enemy",
								selector = "picked",
								area_list = {
									area = {
										"hero",
										"desk",
									},
								},
								no_target_cast = "false",
							},
						},
					},
				},
				cost = "4",
				role = "0",
				set = "0",
				race = "0",
				cndescription = "pet卡奥",
				cnname = "pet卡奥",
				description = "card_2001_desc",
				health = "5",
				type = {
					_text = "pet",
					choose = "false",
				},
				timing_list = {
					timing = {
						"enter",
					},
					off = "die",
					on = "enter",
				},
				camp = "4",
				quality = "1",
				music = {
				},
				attack = "3",
				meta = "2001",
				name = "card_2001_name",
			},
			[2002] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				skill_list = {
					skill = {
						{
							type = "trigger",
							target = {
								force = "self",
								selector = "all",
								area_list = {
									area = {
										"desk",
									},
								},
								card_type = "0",
							},
						},
						{
							type = "attack",
							target = {
								number = "1",
								force = "enemy",
								selector = "picked",
								area_list = {
									area = {
										"hero",
										"desk",
									},
								},
							},
						},
					},
				},
				cost = "5",
				role = "0",
				set = "0",
				race = "0",
				cndescription = "pet奈德",
				cnname = "pet奈德",
				description = "card_2002_desc",
				health = "5",
				type = {
					_text = "pet",
					choose = "false",
				},
				timing_list = {
					timing = {
						"enter",
					},
					off = "enter",
					on = "enter",
				},
				camp = "1",
				quality = "1",
				music = {
				},
				attack = "3",
				meta = "2002",
				name = "card_2002_name",
			},
		},
	},

}
CardMeta = {
	card_list = {
		card = {
			[10001] = {
				skill_list = {
					skill = {
						{
							can_times = "1",
							type = "cast",
							use_times = "0",
							target = {
								cost = {
									max = "-1",
									min = "0",
								},
								role = "0",
								race = "0",
								health = {
									max = "-1",
									min = "0",
								},
								include_self = "false",
								area_list = {
									area = {
										"hero",
									},
								},
								card_type = "0",
								card_id = "0",
								camp = "0",
								no_target_cast = "false",
								quality = "0",
								number = "1",
								attack = {
									max = "-1",
									min = "0",
								},
								force = "self",
								selector = "all",
							},
						},
					},
				},
				cost = "0",
				role = "0",
				set = "0",
				race = "0",
				cndescription = "幸运币1",
				cnname = "幸运币",
				durability = "0",
				description = "LuckyCion",
				health = "0",
				type = {
					miracle = "false",
					choose = "false",
					_text = "magic",
					enchantment = "false",
				},
				timing_list = {
					timing = {
						"cast",
					},
					off = "cast",
					on = "cast",
				},
				camp = "0",
				quality = "1",
				music = {
				},
				soulbound = "0",
				attack = "0",
				meta = "10001",
				name = "LuckyCoin",
			},
			[10002] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				skill_list = {
					skill = {
						{
							type = "self_meta",
							effect = {
								state_list = {
									state = {
										"Taunt",
									},
								},
							},
							target = {
								card_type = "0",
								selector = "self",
							},
						},
						{
							type = "attack",
							target = {
								number = "1",
								force = "enemy",
								include_self = "false",
								selector = "picked",
								area_list = {
									area = {
										"hero",
										"desk",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "1",
				role = "0",
				set = "0",
				race = "0",
				cndescription = "嘲讽。",
				cnname = "闪金镇步兵",
				description = "Taunt",
				health = "2",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "0",
				quality = "1",
				music = {
				},
				soulbound = "0",
				attack = "1",
				meta = "10002",
				name = "Goldshire Footman",
			},
			[10003] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				skill_list = {
					skill = {
						{
							type = "cast",
							target = {
								force = "both",
								include_self = "false",
								selector = "picked",
								area_list = {
									area = {
										"hero",
										"desk",
									},
								},
								card_type = "0",
							},
						},
						{
							type = "attack",
							target = {
								number = "1",
								force = "enemy",
								selector = "picked",
								area_list = {
									area = {
										"hero",
										"desk",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "1",
				role = "0",
				set = "0",
				race = "0",
				cndescription = "战斗怒吼：造成1点伤害。",
				cnname = "精灵射手",
				description = "Battlecry Deal 1 damage.",
				health = "2",
				type = {
					_text = "summoned",
					choose = "false",
				},
				timing_list = {
					timing = {
						"cast",
					},
					off = "cast",
					on = "cast",
				},
				camp = "0",
				quality = "1",
				music = {
				},
				soulbound = "0",
				attack = "2",
				meta = "10003",
				name = "Elven Archer",
			},
			[10004] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				skill_list = {
					skill = {
						{
							type = "cast",
							target = {
								force = "self",
								selector = "all",
								area_list = {
									area = {
										"hero",
									},
								},
								card_type = "0",
							},
						},
						{
							type = "attack",
							target = {
								number = "1",
								force = "enemy",
								selector = "picked",
								area_list = {
									area = {
										"hero",
										"desk",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "1",
				role = "0",
				set = "0",
				race = "0",
				cndescription = "Battlecry Draw a card.",
				cnname = "学徒工程师",
				description = "战斗怒吼：抽1张牌。",
				health = "2",
				type = {
					_text = "summoned",
					choose = "false",
				},
				timing_list = {
					timing = {
						"enter",
					},
					off = "enter",
					on = "enter",
				},
				camp = "0",
				quality = "1",
				music = {
				},
				soulbound = "0",
				attack = "1",
				meta = "10004",
				name = "Novice Engineer",
			},
			[10005] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				skill_list = {
					skill = {
						{
							type = "self_meta",
							effect = {
								state_list = {
									state = {
										"DivineShield",
									},
								},
							},
							target = {
								card_type = "0",
								selector = "self",
							},
						},
						{
							type = "attack",
							target = {
								number = "1",
								force = "enemy",
								selector = "picked",
								area_list = {
									area = {
										"hero",
										"desk",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "1",
				role = "0",
				set = "0",
				race = "0",
				cndescription = "圣盾术",
				cnname = "银色侍从",
				description = "Divine Shield",
				health = "1",
				type = {
					_text = "summoned",
					choose = "false",
				},
				timing_list = {
					timing = {
						"enter",
					},
					off = "die",
					on = "enter",
				},
				camp = "0",
				quality = "1",
				music = {
				},
				soulbound = "0",
				attack = "1",
				meta = "10005",
				name = "Argent Squire",
			},
			[10007] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				skill_list = {
					skill = {
						{
							type = "self_meta",
							effect = {
								state_list = {
									state = {
										"Freeze",
									},
								},
							},
							target = {
								card_type = "0",
								selector = "self",
							},
						},
						{
							type = "attack",
							target = {
								number = "1",
								force = "enemy",
								selector = "picked",
								area_list = {
									area = {
										"hero",
										"desk",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "1",
				role = "0",
				set = "0",
				race = "0",
				cndescription = "冻结任何被该水元素伤害过的角色。",
				cnname = "水元素",
				description = "Freeze any character that Water Elemental damages.",
				health = "6",
				type = {
					_text = "summoned",
					choose = "false",
				},
				timing_list = {
					timing = {
						"enter",
					},
					off = "die",
					on = "enter",
				},
				camp = "0",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "3",
				meta = "10007",
				name = "Water Elemental",
			},
			[10008] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				skill_list = {
					skill = {
						{
							type = "attack",
							target = {
								number = "1",
								force = "enemy",
								selector = "picked",
								area_list = {
									area = {
										"hero",
										"desk",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "1",
				role = "0",
				set = "0",
				race = "0",
				cndescription = "相邻仆从获得+1攻击。",
				cnname = "恐狼阿尔法",
				description = "Adjacent minions have +1 Attack.",
				health = "2",
				type = {
					_text = "summoned",
					choose = "false",
				},
				timing_list = {
					timing = {
						"near",
					},
					off = "die",
					on = "enter",
				},
				camp = "0",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "2",
				meta = "10008",
				name = "Dire Wolf Alpha",
			},
			[10012] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				skill_list = {
					skill = {
						{
							type = "trigger",
							target = {
								areas = {
									area = "hero",
								},
								force = "self",
								include_self = "false",
								selector = "all",
								card_type = "0",
							},
						},
						{
							type = "attack",
							target = {
								number = "1",
								force = "enemy",
								selector = "picked",
								area_list = {
									area = {
										"hero",
										"desk",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "2",
				role = "0",
				set = "0",
				race = "0",
				cndescription = "临死一击：抽1张牌。",
				cnname = "战利品收集者",
				description = "Deathrattle Draw a card.",
				health = "1",
				type = {
					_text = "summoned",
					choose = "false",
				},
				timing_list = {
					timing = {
						"die",
					},
					off = "die",
					on = "die",
				},
				camp = "0",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "2",
				meta = "10012",
				name = "Loot Hoarder",
			},
			[10013] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				skill_list = {
					skill = {
						{
							type = "self_meta",
							effect = {
								state_list = {
									state = {
										"FirstHit",
									},
								},
							},
							target = {
								card_type = "0",
								selector = "self",
							},
						},
						{
							type = "attack",
							target = {
								number = "1",
								force = "enemy",
								selector = "picked",
								area_list = {
									area = {
										"hero",
										"desk",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "2",
				role = "0",
				set = "0",
				race = "0",
				cndescription = "先攻",
				cnname = "装甲战马",
				description = "Divine Shield",
				health = "3",
				type = {
					_text = "summoned",
					choose = "false",
				},
				timing_list = {
					timing = {
						"enter",
					},
					off = "die",
					on = "enter",
				},
				camp = "0",
				quality = "1",
				music = {
				},
				soulbound = "0",
				attack = "1",
				meta = "10013",
				name = "Armored horses",
			},
			[10014] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				skill_list = {
					skill = {
						{
							type = "trigger",
							target = {
								race = "1",
								force = "self",
								include_self = "false",
								selector = "all",
								area_list = {
									area = {
										"desk",
									},
								},
								card_type = "0",
							},
						},
						{
							type = "attack",
							target = {
								number = "1",
								force = "enemy",
								selector = "picked",
								area_list = {
									area = {
										"hero",
										"desk",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "3",
				role = "4",
				set = "0",
				race = "1",
				cndescription = "如果你操控任意的人类仆从，则获得+1/+1",
				cnname = "鲁温爵士",
				description = "If you control any human servant, was +1/+1",
				health = "3",
				type = {
					_text = "summoned",
					choose = "false",
				},
				timing_list = {
					timing = {
						"enter",
						"die",
					},
					off = "die",
					on = "enter",
				},
				camp = "0",
				quality = "1",
				music = {
				},
				soulbound = "0",
				attack = "3",
				meta = "10014",
				name = "Apprentice rider",
			},
			[10020] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "1",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "寒冬城农夫",
				description = "card_10020_desc",
				health = "1",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "1",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "1",
				meta = "10020",
				name = "card_10020_name",
			},
			[10021] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "2",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "守卫守卫",
				cnname = "青年侍从",
				description = "card_10021_desc",
				health = "2",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "1",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "2",
				meta = "10021",
				name = "card_10021_name",
			},
			[10022] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "2",
				role = "0",
				set = "1",
				race = "16",
				cndescription = "嗷嗷嗷嗷嗷",
				cnname = "装甲战马",
				description = "card_10022_desc",
				health = "3",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "1",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "1",
				meta = "10022",
				name = "card_10022_name",
			},
			[10023] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "3",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "见习骑士",
				description = "card_10023_desc",
				health = "3",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "1",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "3",
				meta = "10023",
				name = "card_10023_name",
			},
			[10024] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "3",
				role = "0",
				set = "1",
				race = "16",
				cndescription = "无",
				cnname = "高大驼鹿",
				description = "card_10024_desc",
				health = "4",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "1",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "2",
				meta = "10024",
				name = "card_10024_name",
			},
			[10025] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "4",
				role = "0",
				set = "1",
				race = "16",
				cndescription = "无",
				cnname = "呲牙狗群",
				description = "card_10025_desc",
				health = "4",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "1",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "4",
				meta = "10025",
				name = "card_10025_name",
			},
			[10026] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "4",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "帝都城防军",
				description = "card_10026_desc",
				health = "5",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "1",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "3",
				meta = "10026",
				name = "card_10026_name",
			},
			[10027] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "5",
				role = "0",
				set = "1",
				race = "16",
				cndescription = "无",
				cnname = "草原雄狮",
				description = "card_10027_desc",
				health = "5",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "1",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "4",
				meta = "10027",
				name = "card_10027_name",
			},
			[10028] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "5",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "皇家盾甲兵",
				description = "card_10028_desc",
				health = "6",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "1",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "3",
				meta = "10028",
				name = "card_10028_name",
			},
			[10029] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "6",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "寒冬城剑手",
				description = "card_10029_desc",
				health = "5",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "1",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "5",
				meta = "10029",
				name = "card_10029_name",
			},
			[10030] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "6",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "皇家仪仗兵",
				description = "card_10030_desc",
				health = "6",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "1",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "4",
				meta = "10030",
				name = "card_10030_name",
			},
			[10031] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "7",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "金袍卫士",
				description = "card_10031_desc",
				health = "6",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "1",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "5",
				meta = "10031",
				name = "card_10031_name",
			},
			[10032] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "8",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "圣堂战僧",
				description = "card_10032_desc",
				health = "6",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "1",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "6",
				meta = "10032",
				name = "card_10032_name",
			},
			[10033] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "9",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "骁勇武士",
				description = "card_10033_desc",
				health = "7",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "1",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "7",
				meta = "10033",
				name = "card_10033_name",
			},
			[10034] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "1",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "圣城学徒",
				description = "card_10034_desc",
				health = "1",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "2",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "1",
				meta = "10034",
				name = "card_10034_names",
			},
			[10035] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "1",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "黑水渔夫",
				description = "card_10035_desc",
				health = "1",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "2",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "1",
				meta = "10035",
				name = "card_10035_names",
			},
			[10036] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "2",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "海岸警备队",
				description = "card_10036_desc",
				health = "1",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "2",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "2",
				meta = "10036",
				name = "card_10036_names",
			},
			[10037] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "2",
				role = "0",
				set = "1",
				race = "31",
				cndescription = "无",
				cnname = "锥形鹦鹉螺",
				description = "card_10037_desc",
				health = "3",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "2",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "1",
				meta = "10037",
				name = "card_10037_names",
			},
			[10038] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "3",
				role = "0",
				set = "1",
				race = "31",
				cndescription = "无",
				cnname = "板甲蟹",
				description = "card_10038_desc",
				health = "5",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "2",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "1",
				meta = "10038",
				name = "card_10038_names",
			},
			[10039] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "3",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "黑水湾海盗",
				description = "card_10039_desc",
				health = "3",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "2",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "3",
				meta = "10039",
				name = "card_10039_names",
			},
			[10040] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "4",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "灯塔守卫",
				description = "card_10040_desc",
				health = "6",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "2",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "2",
				meta = "10040",
				name = "card_10040_names",
			},
			[10041] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "4",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "沼泽地原住民",
				description = "card_10041_desc",
				health = "5",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "2",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "3",
				meta = "10041",
				name = "card_10041_names",
			},
			[10042] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "5",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "海港保镖",
				description = "card_10042_desc",
				health = "6",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "2",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "3",
				meta = "10042",
				name = "card_10042_names",
			},
			[10043] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "5",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "激流堡卫兵",
				description = "card_10043_desc",
				health = "5",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "2",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "4",
				meta = "10043",
				name = "card_10043_names",
			},
			[10044] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "6",
				role = "0",
				set = "1",
				race = "20",
				cndescription = "无",
				cnname = "激流巡逻艇",
				description = "card_10044_desc",
				health = "7",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "2",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "3",
				meta = "10044",
				name = "card_10044_names",
			},
			[10045] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "7",
				role = "0",
				set = "1",
				race = "31",
				cndescription = "无",
				cnname = "黑章鱼",
				description = "card_10045_desc",
				health = "6",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "2",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "5",
				meta = "10045",
				name = "card_10045_names",
			},
			[10046] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "8",
				role = "0",
				set = "1",
				race = "31",
				cndescription = "无",
				cnname = "大海蛇",
				description = "card_10046_desc",
				health = "6",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "2",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "6",
				meta = "10046",
				name = "card_10046_names",
			},
			[10047] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "9",
				role = "0",
				set = "1",
				race = "20",
				cndescription = "无",
				cnname = "黑水战舰",
				description = "card_10047_desc",
				health = "8",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "2",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "6",
				meta = "10047",
				name = "card_10047_names",
			},
			[10048] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "1",
				role = "0",
				set = "1",
				race = "16",
				cndescription = "无",
				cnname = "水沟老鼠",
				description = "card_10048_desc",
				health = "1",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "3",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "1",
				meta = "10048",
				name = "card_10048_names",
			},
			[10049] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "2",
				role = "0",
				set = "1",
				race = "10",
				cndescription = "无",
				cnname = "游荡鬼灵",
				description = "card_10049_desc",
				health = "1",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "3",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "2",
				meta = "10049",
				name = "card_10049_names",
			},
			[10050] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "3",
				role = "0",
				set = "1",
				race = "17",
				cndescription = "无",
				cnname = "酸液蛆虫",
				description = "card_10050_desc",
				health = "2",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "3",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "4",
				meta = "10050",
				name = "card_10050_names",
			},
			[10051] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "3",
				role = "0",
				set = "1",
				race = "7",
				cndescription = "无",
				cnname = "墓地骷髅妖",
				description = "card_10051_desc",
				health = "1",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "3",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "5",
				meta = "10051",
				name = "card_10051_names",
			},
			[10052] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "4",
				role = "0",
				set = "1",
				race = "17",
				cndescription = "无",
				cnname = "腐沼甲虫",
				description = "card_10052_desc",
				health = "4",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "3",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "4",
				meta = "10052",
				name = "card_10052_names",
			},
			[10053] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "4",
				role = "0",
				set = "1",
				race = "8",
				cndescription = "无",
				cnname = "高大僵尸",
				description = "card_10053_desc",
				health = "3",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "3",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "5",
				meta = "10053",
				name = "card_10053_names",
			},
			[10054] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "4",
				role = "0",
				set = "1",
				race = "16",
				cndescription = "无",
				cnname = "幼年蜥狮",
				description = "card_10054_desc",
				health = "2",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "3",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "6",
				meta = "10054",
				name = "card_10054_names",
			},
			[10055] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "5",
				role = "0",
				set = "1",
				race = "8",
				cndescription = "无",
				cnname = "蹒跚尸鬼",
				description = "card_10055_desc",
				health = "4",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "3",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "5",
				meta = "10055",
				name = "card_10055_names",
			},
			[10056] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "5",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "泽地蛮族",
				description = "card_10056_desc",
				health = "3",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "3",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "6",
				meta = "10056",
				name = "card_10056_names",
			},
			[10057] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "6",
				role = "0",
				set = "1",
				race = "16",
				cndescription = "无",
				cnname = "沼地蟒蛇",
				description = "card_10057_desc",
				health = "4",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "3",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "6",
				meta = "10057",
				name = "card_10057_names",
			},
			[10058] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "6",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "泽地斗客",
				description = "card_10058_desc",
				health = "3",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "3",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "7",
				meta = "10058",
				name = "card_10058_names",
			},
			[10059] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "7",
				role = "0",
				set = "1",
				race = "16",
				cndescription = "无",
				cnname = "沼泽长吻鳄",
				description = "card_10059_desc",
				health = "5",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "3",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "6",
				meta = "10059",
				name = "card_10059_names",
			},
			[10060] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "8",
				role = "0",
				set = "1",
				race = "8",
				cndescription = "无",
				cnname = "尸鬼骑士",
				description = "card_10060_desc",
				health = "5",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "3",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "7",
				meta = "10060",
				name = "card_10060_names",
			},
			[10061] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "9",
				role = "0",
				set = "1",
				race = "3",
				cndescription = "无",
				cnname = "腐化巨龙",
				description = "card_10061_desc",
				health = "6",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "3",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "8",
				meta = "10061",
				name = "card_10061_names",
			},
			[10062] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "1",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "红袍僧侍女",
				description = "card_10062_desc",
				health = "1",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "4",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "1",
				meta = "10062",
				name = "card_10062_names",
			},
			[10063] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "2",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "可汗奴仆",
				description = "card_10063_desc",
				health = "1",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "4",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "2",
				meta = "10063",
				name = "card_10063_names",
			},
			[10064] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "3",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "暴乱镇民",
				description = "card_10064_desc",
				health = "2",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "4",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "4",
				meta = "10064",
				name = "card_10064_names",
			},
			[10065] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "3",
				role = "0",
				set = "1",
				race = "16",
				cndescription = "无",
				cnname = "草原野马",
				description = "card_10065_desc",
				health = "3",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "4",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "3",
				meta = "10065",
				name = "card_10065_names",
			},
			[10066] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "4",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "灼眼部斥候",
				description = "card_10066_desc",
				health = "4",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "4",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "4",
				meta = "10066",
				name = "card_10066_names",
			},
			[10067] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "5",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "卡拉萨勇士",
				description = "card_10067_desc",
				health = "4",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "4",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "5",
				meta = "10067",
				name = "card_10067_names",
			},
			[10068] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "6",
				role = "0",
				set = "1",
				race = "16",
				cndescription = "无",
				cnname = "火山长角蜥",
				description = "card_10068_desc",
				health = "4",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "4",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "6",
				meta = "10068",
				name = "card_10068_names",
			},
			[10069] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "6",
				role = "0",
				set = "1",
				race = "16",
				cndescription = "无",
				cnname = "高山剑齿兽",
				description = "card_10069_desc",
				health = "5",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "4",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "5",
				meta = "10069",
				name = "card_10069_names",
			},
			[10070] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "7",
				role = "0",
				set = "1",
				race = "17",
				cndescription = "无",
				cnname = "巨型毒虫",
				description = "card_10070_desc",
				health = "4",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "4",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "7",
				meta = "10070",
				name = "card_10070_names",
			},
			[10071] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "7",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "黑耳部战士",
				description = "card_10071_desc",
				health = "5",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "4",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "6",
				meta = "10071",
				name = "card_10071_names",
			},
			[10072] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "8",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "峡谷蛮兵",
				description = "card_10072_desc",
				health = "6",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "4",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "6",
				meta = "10072",
				name = "card_10072_names",
			},
			[10073] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "8",
				role = "0",
				set = "1",
				race = "40",
				cndescription = "无",
				cnname = "食人魔斗士",
				description = "card_10073_desc",
				health = "5",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "4",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "7",
				meta = "10073",
				name = "card_10073_names",
			},
			[10074] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "9",
				role = "0",
				set = "1",
				race = "2",
				cndescription = "无",
				cnname = "笨拙龙兽",
				description = "card_10074_desc",
				health = "5",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "4",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "9",
				meta = "10074",
				name = "card_10074_names",
			},
			[10075] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "9",
				role = "0",
				set = "1",
				race = "12",
				cndescription = "无",
				cnname = "山脊巨人",
				description = "card_10075_desc",
				health = "6",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "4",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "8",
				meta = "10075",
				name = "card_10075_names",
			},
			[10076] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "1",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "林地伐木人",
				description = "card_10076_desc",
				health = "1",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "5",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "2",
				meta = "10076",
				name = "card_10076_names",
			},
			[10077] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "1",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "北地野人",
				description = "card_10077_desc",
				health = "2",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "5",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "1",
				meta = "10077",
				name = "card_10077_names",
			},
			[10078] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "2",
				role = "0",
				set = "1",
				race = "16",
				cndescription = "无",
				cnname = "林地树蛇",
				description = "card_10078_desc",
				health = "3",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "5",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "2",
				meta = "10078",
				name = "card_10078_names",
			},
			[10079] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "2",
				role = "0",
				set = "1",
				race = "16",
				cndescription = "无",
				cnname = "冰原麋鹿",
				description = "card_10079_desc",
				health = "2",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "5",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "3",
				meta = "10079",
				name = "card_10079_names",
			},
			[10080] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "3",
				role = "0",
				set = "1",
				race = "16",
				cndescription = "无",
				cnname = "饥饿的冰原狼",
				description = "card_10080_desc",
				health = "4",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "5",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "3",
				meta = "10080",
				name = "card_10080_names",
			},
			[10081] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "4",
				role = "0",
				set = "1",
				race = "16",
				cndescription = "无",
				cnname = "林地野猪",
				description = "card_10081_desc",
				health = "5",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "5",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "4",
				meta = "10081",
				name = "card_10081_names",
			},
			[10082] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "4",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "狼林猎手",
				description = "card_10082_desc",
				health = "4",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "5",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "5",
				meta = "10082",
				name = "card_10082_names",
			},
			[10083] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "5",
				role = "0",
				set = "1",
				race = "37",
				cndescription = "无",
				cnname = "哨兵树妖",
				description = "card_10083_desc",
				health = "5",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "5",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "5",
				meta = "10083",
				name = "card_10083_names",
			},
			[10084] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "5",
				role = "0",
				set = "1",
				race = "37",
				cndescription = "无",
				cnname = "红木树妖",
				description = "card_10084_desc",
				health = "6",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "5",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "4",
				meta = "10084",
				name = "card_10084_names",
			},
			[10085] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "6",
				role = "0",
				set = "1",
				race = "16",
				cndescription = "无",
				cnname = "疾奔野牛",
				description = "card_10085_desc",
				health = "6",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "5",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "5",
				meta = "10085",
				name = "card_10085_names",
			},
			[10086] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "6",
				role = "0",
				set = "1",
				race = "16",
				cndescription = "无",
				cnname = "北地白熊",
				description = "card_10086_desc",
				health = "5",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "5",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "6",
				meta = "10086",
				name = "card_10086_names",
			},
			[10087] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "7",
				role = "0",
				set = "1",
				race = "16",
				cndescription = "无",
				cnname = "鞭尾鳄鱼",
				description = "card_10087_desc",
				health = "6",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "5",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "6",
				meta = "10087",
				name = "card_10087_names",
			},
			[10088] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "8",
				role = "0",
				set = "1",
				race = "37",
				cndescription = "无",
				cnname = "橡树妖",
				description = "card_10088_desc",
				health = "6",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "5",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "7",
				meta = "10088",
				name = "card_10088_names",
			},
			[10089] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "9",
				role = "0",
				set = "1",
				race = "37",
				cndescription = "无",
				cnname = "铁树妖",
				description = "card_10089_desc",
				health = "7",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "5",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "8",
				meta = "10089",
				name = "card_10089_names",
			},
			[10090] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "1",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "黑旗军新兵",
				description = "card_10090_desc",
				health = "1",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "6",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "1",
				meta = "10090",
				name = "card_10090_names",
			},
			[10091] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "2",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "黑旗军逃兵",
				description = "card_10091_desc",
				health = "1",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "6",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "2",
				meta = "10091",
				name = "card_10091_names",
			},
			[10092] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "4",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "自由骑手",
				description = "card_10092_desc",
				health = "4",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "6",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "4",
				meta = "10092",
				name = "card_10092_names",
			},
			[10093] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "5",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "北地巡林者",
				description = "card_10093_desc",
				health = "6",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "6",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "3",
				meta = "10093",
				name = "card_10093_names",
			},
			[10094] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "6",
				role = "0",
				set = "1",
				race = "1",
				cndescription = "无",
				cnname = "流浪武士",
				description = "card_10094_desc",
				health = "5",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "6",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "5",
				meta = "10094",
				name = "card_10094_names",
			},
			[60001] = {
				tip_list = {
					tip = {
						"3",
					},
				},
				skill_list = {
					skill = {
						{
							type = "self_meta",
							effect = {
								state_list = {
									state = {
										"FirstHit",
									},
								},
							},
							target = {
								card_type = "0",
								selector = "self",
							},
						},
					},
				},
				cost = "1",
				role = "0",
				set = "999",
				race = "1",
				cndescription = "无",
				cnname = "寒冬城侍卫",
				description = "card_60001_desc",
				health = "1",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "1",
				quality = "1",
				music = {
					death = "nansiwang_1",
				},
				soulbound = "0",
				attack = "1",
				meta = "60001",
				name = "card_60001_names",
			},
			[60002] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				skill_list = {
					skill = {
						{
							type = "trigger",
							target = {
								force = "self",
								include_self = "true",
								selector = "all",
								area_list = {
									area = {
										"desk",
									},
								},
								card_type = "summoned",
							},
						},
					},
				},
				cost = "4",
				role = "0",
				set = "999",
				race = "1",
				cndescription = "无",
				cnname = "罗德斯爵士",
				description = "card_60002_desc",
				health = "3",
				type = {
					_text = "summoned",
					choose = "false",
				},
				timing_list = {
					timing = {
						"enter",
					},
					off = "enter",
					on = "enter",
				},
				camp = "1",
				quality = "2",
				music = {
					death = "nansiwang_1",
				},
				soulbound = "1",
				attack = "3",
				meta = "60002",
				name = "card_60002_names",
			},
			[60003] = {
				tip_list = {
					tip = {
						"3",
					},
				},
				skill_list = {
					skill = {
						{
							type = "self_meta",
							effect = {
								state_list = {
									state = {
										"FirstHit",
									},
								},
							},
							target = {
								card_type = "0",
								selector = "self",
							},
						},
					},
				},
				cost = "3",
				role = "0",
				set = "999",
				race = "1",
				cndescription = "无",
				cnname = "侍卫队长",
				description = "card_60003_desc",
				health = "2",
				type = {
					_text = "summoned",
					choose = "false",
				},
				timing_list = {
					timing = {
						"takedamage",
					},
					off = "die",
					on = "enter",
				},
				camp = "1",
				quality = "3",
				music = {
					death = "nansiwang_1",
				},
				soulbound = "1",
				attack = "3",
				meta = "60003",
				name = "card_60003_names",
			},
			[60004] = {
				tip_list = {
					tip = {
						"2",
					},
				},
				cost = "3",
				role = "0",
				set = "999",
				race = "1",
				cndescription = "无",
				cnname = "骑士杰拉",
				description = "card_60004_desc",
				health = "3",
				type = {
					_text = "summoned",
					choose = "false",
				},
				timing_list = {
					timing = {
						"attack",
					},
					off = "die",
					on = "enter",
				},
				camp = "1",
				quality = "2",
				music = {
					death = "nansiwang_1",
					buff = "buff_3",
				},
				soulbound = "1",
				attack = "3",
				meta = "60004",
				name = "card_60004_names",
			},
			[60005] = {
				tip_list = {
					tip = {
						"5",
					},
				},
				skill_list = {
					skill = {
						{
							type = "self_meta",
							effect = {
								state_list = {
									state = {
										"Lifelink",
									},
								},
							},
							target = {
								card_type = "0",
								selector = "self",
							},
						},
						{
							type = "trigger",
							target = {
								force = "self",
								include_self = "true",
								selector = "all",
								area_list = {
									area = {
										"desk",
									},
								},
								card_type = "summoned",
							},
						},
						{
							type = "attack",
							target = {
								number = "1",
								force = "enemy",
								selector = "picked",
								area_list = {
									area = {
										"hero",
										"desk",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "7",
				role = "0",
				set = "999",
				race = "1",
				cndescription = "无",
				cnname = "北境战神",
				description = "card_60005_desc",
				health = "4",
				type = {
					_text = "summoned",
					choose = "false",
				},
				timing_list = {
					timing = {
						"restorehealth",
					},
					off = "die",
					on = "enter",
				},
				camp = "1",
				quality = "3",
				music = {
					death = "nansiwang_1",
				},
				soulbound = "1",
				attack = "3",
				meta = "60005",
				name = "card_60005_names",
			},
			[60006] = {
				tip_list = {
					tip = {
						"4",
					},
				},
				skill_list = {
					skill = {
						{
							type = "self_meta",
							effect = {
								state_list = {
									state = {
										"Taunt",
									},
								},
							},
							target = {
								card_type = "0",
								selector = "self",
							},
						},
						{
							can_times = "0",
							type = "attack",
							target = {
								number = "1",
								force = "enemy",
								selector = "picked",
								area_list = {
									area = {
										"hero",
										"desk",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "2",
				role = "0",
				set = "999",
				race = "1",
				cndescription = "无",
				cnname = "巨盾护卫",
				description = "card_60006_desc",
				health = "6",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "1",
				quality = "1",
				music = {
					death = "nansiwang_1",
				},
				soulbound = "1",
				attack = "0",
				meta = "60006",
				name = "card_60006_names",
			},
			[60007] = {
				tip_list = {
					tip = {
						"3",
						"4",
					},
				},
				skill_list = {
					skill = {
						{
							type = "self_meta",
							effect = {
								state_list = {
									state = {
										"Taunt",
										"FirstHit",
									},
								},
							},
							target = {
								card_type = "0",
								selector = "self",
							},
						},
						{
							can_times = "0",
							type = "attack",
							target = {
								number = "1",
								force = "enemy",
								selector = "picked",
								area_list = {
									area = {
										"hero",
										"desk",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "1",
				role = "0",
				set = "999",
				race = "1",
				cndescription = "无",
				cnname = "寒冬城盾枪兵",
				description = "card_60007_desc",
				health = "3",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "1",
				quality = "1",
				music = {
					death = "nansiwang_1",
				},
				soulbound = "1",
				attack = "1",
				meta = "60007",
				name = "card_60007_names",
			},
			[60008] = {
				cost = "3",
				role = "0",
				set = "999",
				race = "1",
				cndescription = "无",
				cnname = "圣堂战僧",
				description = "card_60008_desc",
				health = "3",
				type = {
					_text = "summoned",
					choose = "false",
				},
				timing_list = {
					timing = {
						"enter",
					},
					off = "die",
					on = "enter",
				},
				camp = "1",
				quality = "3",
				music = {
					death = "nansiwang_1",
				},
				soulbound = "1",
				attack = "2",
				meta = "60008",
				name = "card_60008_names",
			},
			[60009] = {
				tip_list = {
					tip = {
						"4",
						"5",
					},
				},
				skill_list = {
					skill = {
						{
							type = "self_meta",
							effect = {
								state_list = {
									state = {
										"Taunt",
										"Lifelink",
									},
								},
							},
							target = {
								card_type = "0",
								selector = "self",
							},
						},
					},
				},
				cost = "5",
				role = "0",
				set = "999",
				race = "1",
				cndescription = "无",
				cnname = "七神殿圣武士",
				description = "card_60009_desc",
				health = "4",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "1",
				quality = "1",
				music = {
					death = "nansiwang_1",
				},
				soulbound = "1",
				attack = "2",
				meta = "60009",
				name = "card_60009_names",
			},
			[60010] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				cost = "7",
				role = "0",
				set = "999",
				race = "1",
				cndescription = "无",
				cnname = "旧神化身",
				description = "card_60010_desc",
				health = "1",
				type = {
					_text = "summoned",
					choose = "false",
				},
				timing_list = {
					timing = {
						"enter",
					},
					off = "die",
					on = "enter",
				},
				camp = "1",
				quality = "3",
				music = {
					death = "nvsiwang_2.mp3",
				},
				soulbound = "1",
				attack = "0",
				meta = "60010",
				name = "card_60010_names",
			},
			[60011] = {
				skill_list = {
					skill = {
						{
							type = "cast",
							target = {
								force = "both",
								selector = "picked",
								area_list = {
									area = {
										"desk",
									},
								},
								card_type = "summoned",
							},
						},
					},
				},
				cost = "1",
				role = "0",
				set = "999",
				race = "0",
				cndescription = "无",
				cnname = "无畏一击",
				description = "card_60011_desc",
				health = "1",
				type = {
					_text = "magic",
					choose = "false",
				},
				timing_list = {
					timing = {
						"cast",
					},
					off = "cast",
					on = "cast",
				},
				camp = "0",
				quality = "1",
				music = {
					buff = "buff_3",
				},
				soulbound = "1",
				attack = "0",
				meta = "60011",
				name = "card_60011_names",
			},
			[60012] = {
				skill_list = {
					skill = {
						{
							type = "cast",
							target = {
								force = "self",
								selector = "trigger",
								area_list = {
									area = {
										"hero",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "4",
				role = "0",
				set = "999",
				race = "0",
				cndescription = "无",
				cnname = "再次补给",
				description = "card_60012_desc",
				health = "1",
				type = {
					_text = "magic",
					choose = "false",
				},
				timing_list = {
					timing = {
						"cast",
					},
					off = "cast",
					on = "cast",
				},
				camp = "1",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "0",
				meta = "60012",
				name = "card_60012_names",
			},
			[60013] = {
				skill_list = {
					skill = {
						{
							type = "cast",
							target = {
								force = "both",
								selector = "picked",
								area_list = {
									area = {
										"desk",
									},
								},
								card_type = "summoned",
							},
						},
					},
				},
				cost = "2",
				role = "0",
				set = "999",
				race = "0",
				cndescription = "无",
				cnname = "剥夺战心",
				description = "card_60013_desc",
				health = "0",
				type = {
					choose = "false",
					_text = "magic",
					enchantment = "true",
				},
				timing_list = {
					timing = {
						"cast",
					},
					off = "cast",
					on = "cast",
				},
				camp = "1",
				quality = "1",
				music = {
					buff = "buff_3",
				},
				soulbound = "1",
				attack = "0",
				meta = "60013",
				name = "card_60013_names",
			},
			[60014] = {
				skill_list = {
					skill = {
						{
							type = "cast",
							target = {
								health = {
									max = "-1",
									min = "4",
								},
								force = "both",
								selector = "picked",
								area_list = {
									area = {
										"desk",
									},
								},
								card_type = "summoned",
							},
						},
					},
				},
				cost = "2",
				role = "0",
				set = "999",
				race = "0",
				cndescription = "无",
				cnname = "无坚不摧",
				description = "card_60014_desc",
				health = "0",
				type = {
					_text = "magic",
					choose = "false",
				},
				timing_list = {
					timing = {
						"cast",
					},
					off = "cast",
					on = "cast",
				},
				camp = "1",
				quality = "2",
				music = {
				},
				soulbound = "1",
				attack = "0",
				meta = "60014",
				name = "card_60014_names",
			},
			[60015] = {
				skill_list = {
					skill = {
						{
							type = "cast",
							target = {
								force = "both",
								selector = "picked",
								area_list = {
									area = {
										"desk",
									},
								},
								card_type = "summoned",
							},
						},
					},
				},
				cost = "3",
				role = "0",
				set = "999",
				race = "0",
				cndescription = "无",
				cnname = "庄严献祭",
				description = "card_60015_desc",
				health = "0",
				type = {
					_text = "magic",
					choose = "false",
				},
				timing_list = {
					timing = {
						"cast",
					},
					off = "cast",
					on = "cast",
				},
				camp = "1",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "0",
				meta = "60015",
				name = "card_60015_names",
			},
			[60034] = {
				cost = "3",
				role = "0",
				set = "999",
				race = "0",
				cndescription = "无",
				cnname = "列阵迎击",
				description = "card_60034_desc",
				health = "0",
				type = {
					_text = "magic",
					choose = "false",
				},
				timing_list = {
					off = "cast",
					on = "cast",
				},
				camp = "1",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "0",
				meta = "60034",
				name = "card_60034_names",
			},
			[60033] = {
				skill_list = {
					skill = {
						{
							type = "cast",
							target = {
								force = "self",
								selector = "trigger",
								area_list = {
									area = {
										"desk",
									},
								},
								card_type = "summoned",
								no_target_cast = "true",
							},
						},
					},
				},
				cost = "0",
				role = "0",
				set = "999",
				race = "0",
				cnname = "列阵迎击1",
				description = "card_60033_desc",
				health = "0",
				type = {
					_text = "magic",
					choose = "false",
				},
				timing_list = {
					timing = {
						"cast",
					},
					off = "cast",
					on = "cast",
				},
				camp = "1",
				quality = "1",
				music = {
				},
				soulbound = "0",
				attack = "0",
				meta = "60033",
				name = "card_60033_names",
			},
			[60016] = {
				skill_list = {
					skill = {
						{
							type = "cast",
							target = {
								force = "self",
								selector = "all",
								area_list = {
									area = {
										"desk",
									},
								},
								card_type = "summoned",
								no_target_cast = "true",
							},
						},
					},
				},
				cost = "3",
				role = "0",
				set = "999",
				race = "0",
				cnname = "列阵迎击2",
				description = "card_60016_desc",
				health = "0",
				type = {
					_text = "magic",
					choose = "false",
				},
				timing_list = {
					timing = {
						"cast",
					},
					off = "cast",
					on = "cast",
				},
				camp = "1",
				quality = "1",
				music = {
					buff = "buff_3",
				},
				soulbound = "0",
				attack = "0",
				meta = "60016",
				name = "card_60016_names",
			},
			[60017] = {
				tip_list = {
					tip = {
						"2",
					},
				},
				skill_list = {
					skill = {
						{
							type = "trigger",
							target = {
								force = "self",
								selector = "all",
								area_list = {
									area = {
										"desk",
									},
								},
								card_type = "summoned",
							},
						},
						{
							type = "attack",
							target = {
								number = "1",
								force = "enemy",
								selector = "picked",
								area_list = {
									area = {
										"hero",
										"desk",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "2",
				role = "0",
				set = "999",
				race = "1",
				cndescription = "无",
				cnname = "流亡者杰拉",
				description = "card_60017_desc",
				health = "2",
				type = {
					_text = "summoned",
					choose = "false",
				},
				timing_list = {
					timing = {
						"attack",
					},
					off = "die",
					on = "enter",
				},
				camp = "4",
				quality = "3",
				music = {
					death = "nansiwang_2",
				},
				soulbound = "1",
				attack = "2",
				meta = "60017",
				name = "card_60017_names",
			},
			[60018] = {
				tip_list = {
					tip = {
						"2",
					},
				},
				skill_list = {
					skill = {
						{
							type = "attack",
							target = {
								number = "1",
								force = "enemy",
								selector = "picked",
								area_list = {
									area = {
										"hero",
										"desk",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "1",
				role = "0",
				set = "999",
				race = "1",
				cndescription = "无",
				cnname = "草原劫掠者",
				description = "card_60018_desc",
				health = "2",
				type = {
					_text = "summoned",
					choose = "false",
				},
				timing_list = {
					timing = {
						"attack",
					},
					off = "die",
					on = "enter",
				},
				camp = "4",
				quality = "1",
				music = {
					death = "nansiwang_2",
				},
				soulbound = "1",
				attack = "1",
				meta = "60018",
				name = "card_60018_names",
			},
			[60019] = {
				skill_list = {
					skill = {
						{
							type = "attack",
							target = {
								number = "1",
								force = "enemy",
								selector = "picked",
								area_list = {
									area = {
										"hero",
										"desk",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "1",
				role = "0",
				set = "999",
				race = "1",
				cndescription = "无",
				cnname = "可汗部众",
				description = "card_60019_desc",
				health = "1",
				type = {
					_text = "summoned",
					choose = "false",
				},
				timing_list = {
					timing = {
						"enter",
					},
					off = "die",
					on = "enter",
				},
				camp = "4",
				quality = "2",
				music = {
					death = "nansiwang_2",
				},
				soulbound = "1",
				attack = "1",
				meta = "60019",
				name = "card_60019_names",
			},
			[60020] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				skill_list = {
					skill = {
						{
							type = "cast",
							target = {
								health = {
									max = "2",
									min = "0",
								},
								force = "both",
								selector = "picked",
								area_list = {
									area = {
										"desk",
									},
								},
								card_type = "summoned",
								no_target_cast = "true",
							},
						},
						{
							type = "attack",
							target = {
								number = "1",
								force = "enemy",
								selector = "picked",
								area_list = {
									area = {
										"desk",
										"hero",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "2",
				role = "0",
				set = "999",
				race = "1",
				cndescription = "无",
				cnname = "狼牙打击者",
				description = "card_60020_desc",
				health = "2",
				type = {
					_text = "summoned",
					choose = "false",
				},
				timing_list = {
					timing = {
						"cast",
					},
					off = "cast",
					on = "cast",
				},
				camp = "4",
				quality = "2",
				music = {
					death = "nansiwang_2",
				},
				soulbound = "1",
				attack = "2",
				meta = "60020",
				name = "card_60020_names",
			},
			[60021] = {
				tip_list = {
					tip = {
						"6",
					},
				},
				skill_list = {
					skill = {
						{
							type = "self_meta",
							effect = {
								state_list = {
									state = {
										"Charge",
									},
								},
							},
							target = {
								card_type = "0",
								selector = "self",
							},
						},
						{
							type = "attack",
							target = {
								number = "1",
								force = "enemy",
								selector = "picked",
								area_list = {
									area = {
										"hero",
										"desk",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "4",
				role = "0",
				set = "999",
				race = "1",
				cndescription = "无",
				cnname = "草原弓骑兵",
				description = "card_60021_desc",
				health = "3",
				type = {
					_text = "summoned",
					choose = "false",
				},
				timing_list = {
					timing = {
						"attack",
					},
					off = "die",
					on = "enter",
				},
				camp = "4",
				quality = "3",
				music = {
					death = "nansiwang_2",
				},
				soulbound = "1",
				attack = "3",
				meta = "60021",
				name = "card_60021_names",
			},
			[60022] = {
				tip_list = {
					tip = {
						"6",
					},
				},
				skill_list = {
					skill = {
						{
							type = "self_meta",
							effect = {
								state_list = {
									state = {
										"Charge",
									},
								},
							},
							target = {
								card_type = "0",
								selector = "self",
							},
						},
						{
							type = "attack",
							target = {
								number = "1",
								force = "enemy",
								selector = "picked",
								area_list = {
									area = {
										"hero",
										"desk",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "3",
				role = "0",
				set = "999",
				race = "1",
				cndescription = "哈哈",
				cnname = "血盟杀戮者",
				description = "card_60022_desc",
				health = "1",
				type = {
					_text = "summoned",
					choose = "false",
				},
				timing_list = {
					timing = {
						"takedamage",
					},
					off = "die",
					on = "enter",
				},
				camp = "4",
				quality = "2",
				music = {
					death = "nansiwang_2",
				},
				soulbound = "1",
				attack = "2",
				meta = "60022",
				name = "card_60022_names",
			},
			[60023] = {
				tip_list = {
					tip = {
						"9",
					},
				},
				skill_list = {
					skill = {
						{
							type = "self_meta",
							effect = {
								state_list = {
									state = {
										"Trample",
									},
								},
							},
							target = {
								card_type = "0",
								selector = "self",
							},
						},
						{
							type = "attack",
							target = {
								number = "1",
								force = "enemy",
								selector = "picked",
								area_list = {
									area = {
										"hero",
										"desk",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "2",
				role = "0",
				set = "999",
				race = "1",
				cndescription = "无",
				cnname = "狼牙猛击手",
				description = "card_60023_desc",
				health = "2",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "4",
				quality = "1",
				music = {
					death = "nansiwang_2",
				},
				soulbound = "1",
				attack = "2",
				meta = "60023",
				name = "card_60023_names",
			},
			[60024] = {
				tip_list = {
					tip = {
						"7",
					},
				},
				skill_list = {
					skill = {
						{
							type = "self_meta",
							effect = {
								state_list = {
									state = {
										"Windfury",
									},
								},
							},
							target = {
								card_type = "0",
								selector = "self",
							},
						},
						{
							type = "attack",
							target = {
								number = "1",
								force = "enemy",
								selector = "picked",
								area_list = {
									area = {
										"hero",
										"desk",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "3",
				role = "0",
				set = "999",
				race = "1",
				cndescription = "无",
				cnname = "年幼火舞者",
				description = "card_60024_desc",
				health = "1",
				type = {
					_text = "summoned",
					choose = "false",
				},
				timing_list = {
					timing = {
						"takedamage",
					},
					off = "die",
					on = "enter",
				},
				camp = "4",
				quality = "3",
				music = {
					death = "nvsiwang_1",
				},
				soulbound = "1",
				attack = "1",
				meta = "60024",
				name = "card_60024_names",
			},
			[60025] = {
				tip_list = {
					tip = {
						"6",
						"9",
						"8",
					},
				},
				skill_list = {
					skill = {
						{
							type = "self_meta",
							effect = {
								state_list = {
									state = {
										"Trample",
										"Charge",
									},
								},
							},
							target = {
								card_type = "0",
								selector = "self",
							},
						},
						{
							type = "attack",
							target = {
								number = "1",
								force = "enemy",
								selector = "picked",
								area_list = {
									area = {
										"hero",
										"desk",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "3",
				role = "0",
				set = "999",
				race = "1",
				cndescription = "无",
				cnname = "决死骑兵",
				description = "card_60025_desc",
				health = "1",
				type = {
					_text = "summoned",
					choose = "false",
				},
				timing_list = {
					timing = {
						"enter",
					},
					off = "die",
					on = "enter",
				},
				camp = "4",
				quality = "3",
				music = {
					death = "nansiwang_2",
				},
				soulbound = "1",
				attack = "6",
				meta = "60025",
				name = "card_60025_names",
			},
			[60026] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				skill_list = {
					skill = {
						{
							type = "cast",
							target = {
								force = "both",
								selector = "picked",
								area_list = {
									area = {
										"desk",
									},
								},
								card_type = "summoned",
								no_target_cast = "true",
							},
						},
						{
							type = "attack",
							target = {
								number = "1",
								force = "enemy",
								selector = "picked",
								area_list = {
									area = {
										"hero",
										"desk",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "1",
				role = "0",
				set = "999",
				race = "1",
				cndescription = "无",
				cnname = "火焰杂耍人",
				description = "card_60026_desc",
				health = "1",
				type = {
					_text = "summoned",
					choose = "false",
				},
				timing_list = {
					timing = {
						"cast",
					},
					off = "cast",
					on = "cast",
				},
				camp = "4",
				quality = "1",
				music = {
					death = "nvsiwang_1",
				},
				soulbound = "1",
				attack = "2",
				meta = "60026",
				name = "card_60026_names",
			},
			[60027] = {
				skill_list = {
					skill = {
						{
							type = "cast",
							target = {
								force = "self",
								selector = "all",
								area_list = {
									area = {
										"hero",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "5",
				role = "0",
				set = "999",
				race = "0",
				cndescription = "无",
				cnname = "火焰箭雨",
				description = "card_60027_desc",
				health = "0",
				type = {
					_text = "magic",
					choose = "false",
				},
				timing_list = {
					timing = {
						"cast",
					},
					off = "cast",
					on = "cast",
				},
				camp = "4",
				quality = "2",
				music = {
				},
				soulbound = "1",
				attack = "0",
				meta = "60027",
				name = "card_60027_names",
			},
			[60028] = {
				skill_list = {
					skill = {
						{
							type = "cast",
							target = {
								force = "both",
								selector = "picked",
								area_list = {
									area = {
										"desk",
									},
								},
								card_type = "summoned",
							},
						},
					},
				},
				cost = "1",
				role = "0",
				set = "999",
				race = "0",
				cndescription = "无",
				cnname = "点燃怒火",
				description = "card_60028_desc",
				health = "0",
				type = {
					choose = "false",
					_text = "magic",
					enchantment = "true",
				},
				timing_list = {
					timing = {
						"cast",
					},
					off = "cast",
					on = "cast",
				},
				camp = "4",
				quality = "1",
				music = {
					buff = "buff_3",
				},
				soulbound = "1",
				attack = "0",
				meta = "60028",
				name = "card_60028_names",
			},
			[60029] = {
				skill_list = {
					skill = {
						{
							type = "cast",
							target = {
								force = "self",
								selector = "picked",
								area_list = {
									area = {
										"desk",
									},
								},
								card_type = "summoned",
							},
						},
					},
				},
				cost = "2",
				role = "0",
				set = "999",
				race = "0",
				cndescription = "无",
				cnname = "舍身一击",
				description = "card_60029_desc",
				health = "0",
				type = {
					_text = "magic",
					choose = "false",
				},
				timing_list = {
					timing = {
						"cast",
					},
					off = "cast",
					on = "cast",
				},
				camp = "4",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "0",
				meta = "60029",
				name = "card_60029_names",
			},
			[60038] = {
				cost = "3",
				role = "0",
				set = "999",
				race = "0",
				cndescription = "抉择1：对敌方牌手造成3点伤害，并对其操控的仆从造成1点伤害,抉择2：对敌方牌手造成1点伤害，并对其操控的仆从造成2点伤害",
				cnname = "可汗的怒火",
				description = "card_60038_desc",
				health = "0",
				type = {
					_text = "magic",
					choose = "false",
				},
				timing_list = {
					off = "cast",
					on = "cast",
				},
				camp = "4",
				quality = "2",
				music = {
				},
				soulbound = "1",
				attack = "0",
				meta = "60038",
				name = "card_60038_names",
			},
			[60031] = {
				skill_list = {
					skill = {
						{
							type = "cast",
							target = {
								force = "self",
								selector = "trigger",
								area_list = {
									area = {
										"hero",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "1",
				role = "0",
				set = "999",
				race = "0",
				cndescription = "无",
				cnname = "孤注一掷",
				description = "card_60031_desc",
				health = "0",
				type = {
					_text = "magic",
					choose = "false",
				},
				timing_list = {
					timing = {
						"cast",
					},
					off = "cast",
					on = "cast",
				},
				camp = "4",
				quality = "1",
				music = {
				},
				soulbound = "1",
				attack = "0",
				meta = "60031",
				name = "card_60031_names",
			},
			[60032] = {
				skill_list = {
					skill = {
						{
							type = "cast",
							target = {
								force = "self",
								selector = "trigger",
								area_list = {
									area = {
										"desk",
									},
								},
								card_type = "summoned",
								no_target_cast = "true",
							},
						},
					},
				},
				cost = "5",
				role = "0",
				set = "999",
				race = "0",
				cndescription = "无",
				cnname = "狂野冲锋",
				description = "card_60032_desc",
				health = "0",
				type = {
					_text = "magic",
					choose = "false",
				},
				timing_list = {
					timing = {
						"cast",
					},
					off = "cast",
					on = "cast",
				},
				camp = "4",
				quality = "1",
				music = {
					buff = "buff_3",
				},
				soulbound = "1",
				attack = "0",
				meta = "60032",
				name = "card_60032_names",
			},
			[60035] = {
				skill_list = {
					skill = {
						{
							type = "cast",
							target = {
								force = "both",
								selector = "picked",
								area_list = {
									area = {
										"hero",
										"desk",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "0",
				role = "0",
				set = "999",
				race = "0",
				cnname = "火焰箭雨1",
				description = "card_60035_desc",
				health = "0",
				type = {
					_text = "magic",
					choose = "false",
				},
				timing_list = {
					timing = {
						"cast",
						"trun_off",
					},
					off = "trun_off",
					on = "inhand",
				},
				camp = "4",
				quality = "1",
				music = {
				},
				soulbound = "0",
				attack = "0",
				meta = "60035",
				name = "card_60035_names",
			},
			[60036] = {
				skill_list = {
					skill = {
						{
							type = "cast",
							target = {
								force = "both",
								selector = "picked",
								area_list = {
									area = {
										"hero",
										"desk",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "0",
				role = "0",
				set = "999",
				race = "0",
				cnname = "火焰箭雨2",
				description = "card_60036_desc",
				health = "0",
				type = {
					_text = "magic",
					choose = "false",
				},
				timing_list = {
					timing = {
						"cast",
						"trun_off",
					},
					off = "trun_off",
					on = "inhand",
				},
				camp = "4",
				quality = "1",
				music = {
				},
				soulbound = "0",
				attack = "0",
				meta = "60036",
				name = "card_60036_names",
			},
			[60037] = {
				skill_list = {
					skill = {
						{
							type = "cast",
							target = {
								force = "both",
								selector = "picked",
								area_list = {
									area = {
										"hero",
										"desk",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "0",
				role = "0",
				set = "999",
				race = "0",
				cnname = "火焰箭雨3",
				description = "card_60037_desc",
				health = "0",
				type = {
					_text = "magic",
					choose = "false",
				},
				timing_list = {
					timing = {
						"cast",
						"trun_off",
					},
					off = "trun_off",
					on = "inhand",
				},
				camp = "4",
				quality = "1",
				music = {
				},
				soulbound = "0",
				attack = "0",
				meta = "60037",
				name = "card_60037_names",
			},
			[60030] = {
				skill_list = {
					skill = {
						{
							type = "cast",
							target = {
								force = "enemy",
								selector = "trigger",
								area_list = {
									area = {
										"desk",
									},
								},
								card_type = "summoned",
								no_target_cast = "true",
							},
						},
					},
				},
				cost = "3",
				role = "0",
				set = "999",
				race = "0",
				cnname = "可汗的怒火1",
				description = "card_60030_desc",
				health = "0",
				type = {
					_text = "magic",
					choose = "false",
				},
				timing_list = {
					timing = {
						"cast",
					},
					off = "cast",
					on = "cast",
				},
				camp = "4",
				quality = "1",
				music = {
				},
				soulbound = "0",
				attack = "0",
				meta = "60030",
				name = "card_60030_names",
			},
			[60039] = {
				skill_list = {
					skill = {
						{
							type = "cast",
							target = {
								force = "enemy",
								selector = "trigger",
								area_list = {
									area = {
										"desk",
									},
								},
								card_type = "0",
								no_target_cast = "true",
							},
						},
					},
				},
				cost = "0",
				role = "0",
				set = "999",
				race = "0",
				cnname = "可汗的怒火2",
				description = "card_60039_desc",
				health = "0",
				type = {
					_text = "magic",
					choose = "false",
				},
				timing_list = {
					timing = {
						"cast",
					},
					off = "cast",
					on = "cast",
				},
				camp = "4",
				quality = "1",
				music = {
				},
				soulbound = "0",
				attack = "0",
				meta = "60039",
				name = "card_60039_names",
			},
			[60041] = {
				tip_list = {
					tip = {
						"3",
					},
				},
				skill_list = {
					skill = {
						{
							type = "self_meta",
							effect = {
								state_list = {
									state = {
										"FirstHit",
									},
								},
							},
							target = {
								card_type = "0",
								selector = "self",
							},
						},
					},
				},
				cost = "1",
				role = "0",
				set = "999",
				race = "1",
				cndescription = "无",
				cnname = "异画卡1",
				description = "card_60041_desc",
				health = "1",
				type = {
					_text = "summoned",
					choose = "false",
				},
				camp = "1",
				quality = "1",
				music = {
					death = "nansiwang_1",
				},
				soulbound = "0",
				attack = "1",
				meta = "60041",
				name = "card_60041_names",
			},
			[60042] = {
				tip_list = {
					tip = {
						"1",
					},
				},
				skill_list = {
					skill = {
						{
							type = "trigger",
							target = {
								force = "self",
								include_self = "true",
								selector = "all",
								area_list = {
									area = {
										"desk",
									},
								},
								card_type = "summoned",
							},
						},
					},
				},
				cost = "4",
				role = "0",
				set = "999",
				race = "1",
				cndescription = "无",
				cnname = "异画卡2",
				description = "card_60042_desc",
				health = "3",
				type = {
					_text = "summoned",
					choose = "false",
				},
				timing_list = {
					timing = {
						"enter",
					},
					off = "enter",
					on = "enter",
				},
				camp = "1",
				quality = "2",
				music = {
					death = "nansiwang_1",
				},
				soulbound = "1",
				attack = "3",
				meta = "60042",
				name = "card_60042_names",
			},
			[60043] = {
				tip_list = {
					tip = {
						"3",
					},
				},
				skill_list = {
					skill = {
						{
							type = "self_meta",
							effect = {
								state_list = {
									state = {
										"FirstHit",
									},
								},
							},
							target = {
								card_type = "0",
								selector = "self",
							},
						},
					},
				},
				cost = "3",
				role = "0",
				set = "999",
				race = "1",
				cndescription = "无",
				cnname = "异画3",
				description = "card_60043_desc",
				health = "2",
				type = {
					_text = "summoned",
					choose = "false",
				},
				timing_list = {
					timing = {
						"takedamage",
					},
					off = "die",
					on = "enter",
				},
				camp = "1",
				quality = "3",
				music = {
					death = "nansiwang_1",
				},
				soulbound = "1",
				attack = "3",
				meta = "60043",
				name = "card_60043_names",
			},
			[60044] = {
				tip_list = {
					tip = {
						"7",
					},
				},
				skill_list = {
					skill = {
						{
							type = "self_meta",
							effect = {
								state_list = {
									state = {
										"Windfury",
									},
								},
							},
							target = {
								card_type = "0",
								selector = "self",
							},
						},
						{
							type = "attack",
							target = {
								number = "1",
								force = "enemy",
								selector = "picked",
								area_list = {
									area = {
										"hero",
										"desk",
									},
								},
								card_type = "0",
							},
						},
					},
				},
				cost = "3",
				role = "0",
				set = "999",
				race = "1",
				cndescription = "无",
				cnname = "异画4",
				description = "card_60044_desc",
				health = "1",
				type = {
					_text = "summoned",
					choose = "false",
				},
				timing_list = {
					timing = {
						"takedamage",
					},
					off = "die",
					on = "enter",
				},
				camp = "4",
				quality = "3",
				music = {
					death = "nvsiwang_1",
				},
				soulbound = "1",
				attack = "1",
				meta = "60044",
				name = "card_60044_names",
			},
		},
	},

}
