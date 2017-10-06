﻿------------------------------------------------------------------------ 作者：lewis-- 日期：2013-5-4-- 描述：怪物特殊技能----------------------------------------------------------------------SpecialSkill = {}local parseFuncTB = {}	--参数解析函数表local mXmlTB = XmlTable_load("monster_special_skill_tplt.xml", "id")--获得配置信息function SpecialSkill.getConfig(id)	local row = XmlTable_getRow(mXmlTB, id, false)	if nil == row then		return nil	end	return rowend--参数分割function SpecialSkill.parseParamer(str)	local newstr = string.gsub(str, "%s+", "")	local strTB = {}	for k, v in string.gmatch(newstr, "([A-Za-z0-9_.]*)([,=]?)") do		if k ~= "" then			table.insert(strTB, k)		end	end	local paramTB = {}	local idx = 1	local total = #strTB	while true do		if idx + 1 > total then			break		end		paramTB[strTB[idx]] = tonumber(strTB[idx + 1])		idx = idx + 2	end	return paramTBend--设置function SpecialSkill.logic(role, idStr)	--idStr = "44621"	for key, value in string.gmatch(idStr, "([A-Za-z0-9_.]*)([,]?)") do		if key ~= "" then					local id = key + 0			if id > 0 then				SpecialSkill.parse(role, id)			end		end	endend--参数解析function SpecialSkill.parse(role, id)	local info = SpecialSkill.getConfig(id)	if info == nil then		return	end	local func = parseFuncTB[info.name]	if func == nil then		return	end	role:setConfig("specail_skill_id", id)	local str = info.param	local tb = SpecialSkill.parseParamer(str)	func(role, tb)end--预加载function SpecialSkill.preload(idStr)	for key, value in string.gmatch(idStr, "([A-Za-z0-9_.]*)([,]?)") do		if key ~= "" then					local id = key + 0			if id > 0 then				local info = SpecialSkill.getConfig(id)			end		end	endend--偷钱技能参数解析function SpecialSkill.steal_coin(role, tb)	local round = tb["round"] or -1	local percentage = tb["percentage"] or 0	local percentage = percentage / 100	role:setConfig("stay_round", round)	role:setConfig("steal_coin_rate", percentage)end--掉钱技能参数解析function SpecialSkill.drop_out_coin(role, tb)	local round = tb["round"] or -1	if round == 0 then round = -1 end	role:setConfig("stay_round", round)end--重生技能参数解析function SpecialSkill.respawn(role, tb)	local times = tb["times"] or 0	local atk = tb["atk"] or 1	local life = tb["life"] or 1	role:setConfig("respawn_count", times)	role:setConfig("respawn_life_rate", life)	role:setConfig("respawn_atk_rate", atk)end--召唤技能参数解析function SpecialSkill.summon(role, tb)	local id = tb["monsterid"] or 0	role:setConfig("summon_after_death", id)end--肉盾技能参数解析function SpecialSkill.human_shield(role, tb)	local reduction = tb["reduction"] or 0	reduction = reduction / 100	local amp = tb["amp"] or 0	amp = amp / 100	role.mData.mStatus:setStatus("human_shield_damage_reduce", reduction)	role.mData.mStatus:setStatus("status_amplify_damage", amp)end--潜行技能参数解析function SpecialSkill.stealth(role, tb)	local r1 = tb["show"] or 1	local r2 = tb["hide"] or 2	role:setConfig("stealth_available", true)	role:setConfig("stealth_show_round", r1)	role:setConfig("stealth_hide_round", r2)end--狂化技能参数解析function SpecialSkill.frantic(role, tb)	local life = tb["lifeper"]	local atk = tb["atkper"]	role:setConfig("frantic_rate", life / atk)end--物理反伤技能参数解析function SpecialSkill.rebound_damage(role, tb)	local percentage = tb["percentage"] or 0	local percentage = percentage / 100    local magicpercentage = tb["magicpercentage"] or 0    local magicpercentage = magicpercentage / 100	role.mData.mStatus:setStatus("status_damage_rebound_rate", percentage)    role.mData.mStatus:setStatus("status_magic_damage_rate", magicpercentage)end--魔法免役技能参数解析function SpecialSkill.magic_immune(role, tb)	local percentage = tb["percentage"] or 0	local percentage = percentage / 100	role.mData.mStatus:setStatus("status_magic_immune_rate", percentage)end--虚弱光环技能参数解析function SpecialSkill.weak_halo(role, tb)	local id = tb["skillID"] or 0	role:setConfig("skill_weak_halo", id)end--死亡遗愿技能参数解析function SpecialSkill.death_wish(role, tb)	local id = tb["skillID"] or 0	local round = tb["round"] or -1    role:setConfig("explosive_round",round)	if round == 0 then		round = -1	end	role:setConfig("skill_after_death", id)	role:setConfig("stay_round", round)end-- 怪物召唤function SpecialSkill.monster_summon(role,tb)    local summon_monsterid = tb["monsterid"] or 0   --召唤ID    local summon_amount = tb["amount"] or 0         --召唤数量    local summon_round = tb["round"] or 0           --召唤数量	role:setConfig("summon_monsterid", summon_monsterid)    role:setConfig("summon_amount", summon_amount)    role:setConfig("summon_round", summon_round)end --怪物分身function SpecialSkill.separateBody(role,tb)    local separateBody_amount = tb["amount"] or 0       local separateBody_round = tb["round"] or 0 	role:setConfig("separateBody_amount", separateBody_amount)  --分身数量    role:setConfig("separateBody_round", separateBody_round)    --分身间隔    role:setConfig("separateBody_count", 0)                     --分身间隔  计数        role:setConfig("separateBody_damged", tb["damged"] or 0  )  --分身额外伤害倍率    role:setConfig("separateBody_atk", tb["atk"] or 0   )    --分身额外攻击倍率    role:setConfig("separateBody_miss", tb["miss"] or 0   )   --分身额外闪避倍率     endfunction SpecialSkill.devour(role,tb)     role:setConfig("devour_round", tb["round"] or 0)  --吞噬间隔    role:setConfig("devour_preatk", tb["atk"] or 0)  --吞噬间隔攻击endparseFuncTB["monster_summon"]	 	= SpecialSkill.monster_summonparseFuncTB["steal_coin"]	 		= SpecialSkill.steal_coinparseFuncTB["drop_out_coin"] 		= SpecialSkill.drop_out_coinparseFuncTB["respawn"] 				= SpecialSkill.respawnparseFuncTB["summon"] 				= SpecialSkill.summonparseFuncTB["human_shield"] 		= SpecialSkill.human_shieldparseFuncTB["stealth"] 				= SpecialSkill.stealthparseFuncTB["frantic"] 				= SpecialSkill.franticparseFuncTB["rebound_damage"] 		= SpecialSkill.rebound_damageparseFuncTB["magic_immune"] 		= SpecialSkill.magic_immuneparseFuncTB["weak_halo"] 			= SpecialSkill.weak_haloparseFuncTB["death_wish"]			= SpecialSkill.death_wishparseFuncTB["separateBody"]			= SpecialSkill.separateBodyparseFuncTB["devour"]			    = SpecialSkill.devour