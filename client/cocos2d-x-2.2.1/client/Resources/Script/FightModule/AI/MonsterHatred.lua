﻿------------------------------------------------------------------------ 作者：lewis-- 日期：2013-3-31-- 描述： 怪物仇恨值----------------------------------------------------------------------local mAttackHatredTB = {}			--普通攻击仇恨值表local mSkillHatredTB  = {}			--技能攻击仇恨值表local mAOEHatredTB	  = {}			--aoe技能仇恨值表local mHatredTB = {}mHatredTB["attack"]		= mAttackHatredTBmHatredTB["skill"]		= mSkillHatredTBmHatredTB["aoe"]		= mAOEHatredTBMonsterHatred = {}--初始化仇恨值配置function MonsterHatred.initHatred()	--普通攻击	mAttackHatredTB["human_shield"]			= {150, 160}			--肉盾怪	mAttackHatredTB["attack_rebound"]		= {-50, -40}		--物理反伤	mAttackHatredTB["steal"]				= {30, 40}			--偷钱怪	mAttackHatredTB["frantic"]				= {-20, -10}		--狂化怪	mAttackHatredTB["weak_halo"]			= {40, 50}			--虚弱光环怪	mAttackHatredTB["initiative_attack"]	= {50, 60}			--主动怪	mAttackHatredTB["boss"]					= {70, 80}			--boss	mAttackHatredTB["skill"]				= {30, 35}			--技能怪	mAttackHatredTB["stealth_on_hide"]		= {25, 30}			--潜行怪隐身中	mAttackHatredTB["stealth_on_show"]		= {-50, -40}		--潜行怪显行中	mAttackHatredTB["normal"]				= {-30, -20}		--普通怪	mAttackHatredTB["min_hit_points"]		= {40, 50}			--血最少的	mAttackHatredTB["on_stun"]				= {50, 55}			--眩晕中		--单体技能攻击	mSkillHatredTB["human_shield"]			= {60, 60}			--肉盾怪	mSkillHatredTB["attack_rebound"]		= {-50, -40}		--物理反伤	mSkillHatredTB["steal"]					= {30, 40}			--偷钱怪	mSkillHatredTB["frantic"]				= {10, 20}			--狂化怪	mSkillHatredTB["weak_halo"]				= {20, 30}			--虚弱光环怪	mSkillHatredTB["initiative_attack"]		= {40, 50}			--主动怪	mSkillHatredTB["boss"]					= {120, 130}		--boss	mSkillHatredTB["skill"]					= {40, 50}			--技能怪	mSkillHatredTB["stealth_on_hide"]		= {15, 20}			--潜行怪隐身中	mSkillHatredTB["stealth_on_show"]		= {-50, -40}		--潜行怪显行中	mSkillHatredTB["normal"]				= {-30, -20}		--普通怪	mSkillHatredTB["min_hit_points"]		= {40, 50}			--血最少的	mSkillHatredTB["on_stun"]				= {-40, -30}		--眩晕中		--aoe技能攻击	mAOEHatredTB["human_shield"]			= {-360, -350}			--肉盾怪	mAOEHatredTB["attack_rebound"]			= {-50, -40}		--物理反伤	mAOEHatredTB["steal"]					= {30, 40}			--偷钱怪	mAOEHatredTB["frantic"]					= {10, 20}			--狂化怪	mAOEHatredTB["weak_halo"]				= {20, 30}			--虚弱光环怪	mAOEHatredTB["initiative_attack"]		= {40, 50}			--主动怪	mAOEHatredTB["boss"]					= {320, 330}		--boss	mAOEHatredTB["skill"]					= {20, 30}			--技能怪	mAOEHatredTB["stealth_on_hide"]			= {15, 20}			--潜行怪隐身中	mAOEHatredTB["stealth_on_show"]			= {-50, -40}		--潜行怪显行中	mAOEHatredTB["normal"]					= {-30, -20}		--普通怪	mAOEHatredTB["min_hit_points"]			= {40, 50}			--血最少的	mAOEHatredTB["on_stun"]					= {-40, -30}		--眩晕中endMonsterHatred.initHatred()--计算怪物总的仇恨值function MonsterHatred.getHatredWithType(name, monster)	local tb = mHatredTB[name]	if tb == nil then		return 0	end		local marks = MonsterHatred.marksWithMonster(monster)	local total = 0	for key, tag in pairs(marks) do		local unit = tb[tag]		if unit then			local result = math.random(unit[1], unit[2])			total = total + result		end	end	--cclog("Hatred with ", name, total)	return totalend--计算怪物的标签function MonsterHatred.marksWithMonster(monster)	local marks = {}	local status = monster.mData.mStatus	--肉盾怪	local redution = status:getStatus("human_shield_damage_reduce")	if redution > 0 then		table.insert(marks, "human_shield")	end		--反伤怪	local rate = status:getStatus("status_damage_rebound_rate")    local dvalue = status:getStatus("status_damage_rebound_value") 	if rate > 0 then		table.insert(marks, "attack_rebound")	end		--偷钱怪,并已成功偷了钱	if monster:getConfig("drop_out_coins") > 0 then		table.insert(marks, "steal")	end		--狂化怪,不建议普通攻击	if monster:getConfig("frantic_rate") > 0 then		table.insert(marks, "frantic")	end		--虚弱光环怪	if monster:getConfig("skill_weak_halo") ~= 0 then		table.insert(marks, "weak_halo")	end		--主动怪	if monster:getConfig("attack_type") == 1 then		table.insert(marks, "initiative_attack")	end		--boss	if monster:getConfig("is_boss") then		table.insert(marks, "boss")	end		--技能怪	local cnt = monster:getConfig("skill_cnt")	if cnt > 0 then		table.insert(marks, "skill")	end		--潜行怪	if monster:getConfig("stealth_available") then		--潜行中		if monster:getConfig("is_on_stealth") then			table.insert(marks, "stealth_on_hide")		else			table.insert(marks, "stealth_on_show")		end	end			--普通怪,还不如开格子	if eval == 0 then		table.insert(marks, "normal")	else--找血最少的		local hitPoints = monster:getDataInfo("attr").hitPoints		if hitPoints <= AIMgr.getEnvir("min_hit_points") then			table.insert(marks, "min_hit_points")		end	end		--被眩晕了仇恨值增加	if monster:isCommonAttackValid() == false then		table.insert(marks, "on_stun")	end	return marksend