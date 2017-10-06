﻿------------------------------------------------------------------------ 作者：jaron.ho-- 日期：2014-10-22-- 描述：技能配置信息----------------------------------------------------------------------SkillConfig = {}local mSkillTable = XmlTable_load("skill_tplt.xml", "id")									-- 职业技能表local mSkillBaseTable = XmlTable_load("skill_base_info.xml", "skill_id")					-- 技能基础表local mSkillFragTable = XmlTable_load("skill_frag_tplt.xml", "id")							-- 技能碎片表local mSkillBuffTable = XmlTable_load("skill_buff_tplt.xml", "buff_id")						-- 技能状态表local mSkillEffectTable = XmlTable_load("skill_effect_tplt.xml", "effect_id")				-- 技能动画表local mSkillEffectExtsTable = XmlTable_load("skill_effect_exts_tplt.xml", "effect_id")		-- 技能动画扩展表local mSkillUpgradeTable = XmlTable_load("skill_upgrade_tplt.xml", "id")					-- 技能升级表local mSkillAdvanceTable = XmlTable_load("skill_advance_tplt.xml", "id")					-- 技能进阶表local mSkillSpecialSetTB = XmlTable_load("skill_special_set_tplt.xml", "id")                -- 技能特殊设定----------------------------------------------------------------------function SkillConfig.getSkillSpecialSetTB(specId)     return mSkillSpecialSetTB.map[tostring(specId)]end -- 获取技能信息SkillConfig.getSkillInfo = function(skillID)	local row = XmlTable_getRow(mSkillTable, skillID, false)	if nil == row then		return nil	end	local info = {}	info.id = tonumber(row.id)										-- 职业技能id(同时对应技能基础表id)	info.role_type = tonumber(row.role_type)						-- 角色类型:1=战士,2=圣骑,3=萨满,4=法师	info.skill_group = tonumber(row.skill_group)					-- 技能组	info.max_lev = tonumber(row.max_lev)							-- 最高等级	if "0" == row.desc_ids then		info.desc_ids = {}	else		info.desc_ids = CommonFunc_split(row.desc_ids, ",")			-- 描述类型:1=单体伤害,2=群体伤害,3=恢复,4=持续伤害,5=持续恢复,6=控制,7=增益,8=减益,9=群体控制,10=减少伤害,11=吸血,12=驱散状态 13=反弹伤害 14召唤仆从	end	info.upgrate_cost_id = tonumber(row.upgrate_cost_id)			-- 升级花费表id	info.advance_cost_id = tonumber(row.advance_cost_id)			-- 晋阶花费表id	info.unlock_need_id = tonumber(row.unlock_need_id)				-- 解锁所需碎片id	info.unlock_need_amount = tonumber(row.unlock_need_amount)		-- 解锁所需碎片数量	info.attribute_tag = tonumber(row.attribute_tag)				-- 属性标签:0.普通攻击(不参与列表显示),1.伤害,2.辅助,3.治疗	info.equal_frags_amount = tonumber(row.equal_frags_amount)		-- 召唤抽到已有技能转换成碎片的个数	return infoend------------------------------------------------------------------------ 获取技能信息数组(根据:角色类型;每个技能组有且只包含id值最小的技能信息)SkillConfig.getSkillInfoArray = function(roleType)	local infoArray = {}	-- 插入数组	local function insertInfoArray(info)		for key, val in pairs(infoArray) do			if info.skill_group == val.skill_group then				-- 一个技能组只插入一条信息				if info.id < val.id then							-- 初始插入id最小的信息					infoArray[key] = info				end				return			end		end		table.insert(infoArray, info)	end	-- 过滤数据表	for key, val in pairs(mSkillTable.map) do		if tostring(roleType) == val.role_type then			local info = {}			info.id = tonumber(val.id)			info.role_type = tonumber(val.role_type)			info.skill_group = tonumber(val.skill_group)			info.max_lev = tonumber(val.max_lev)			if "0" == val.desc_ids then				info.desc_ids = {}			else				info.desc_ids = CommonFunc_split(val.desc_ids, ",")			end			info.upgrate_cost_id = tonumber(val.upgrate_cost_id)			info.advance_cost_id = tonumber(val.advance_cost_id)			info.unlock_need_id = tonumber(val.unlock_need_id)			info.unlock_need_amount = tonumber(val.unlock_need_amount)			info.attribute_tag = tonumber(val.attribute_tag)			info.equal_frags_amount = tonumber(val.equal_frags_amount)			insertInfoArray(info)		end	end	return infoArrayend------------------------------------------------------------------------ 计算技能冷却回合SkillConfig.calcColdRound = function(skillCD, playerSpeed)	-- 冷却回合 = 冷却时间/玩家最大速度	return math.floor(skillCD/playerSpeed)end------------------------------------------------------------------------ 获取技能类型描述SkillConfig.getTypeDescribe = function(skillDescIds)	-- 描述类型字符串	local typeStr = ""	for key, val in pairs(skillDescIds) do		local runeTypeStr = GameString.get("SKILL_TYPE_"..string.format("%02d", val))		if "" == typeStr then			typeStr = runeTypeStr		else			typeStr = typeStr.."+"..runeTypeStr		end	end	return typeStrend------------------------------------------------------------------------ 获取技能基础信息SkillConfig.getSkillBaseInfo = function(baseID)	local row = XmlTable_getRow(mSkillBaseTable, baseID, false)	if nil == row then		return nil	end	local info = {}	info.id = tonumber(row.skill_id)								-- 技能基础id	info.name = row.skill_name										-- 技能名字	info.icon = row.icon_file_name									-- 图标:技能的图标,填入icon文件夹下的png文件名	info.quality = tonumber(row.frame_file_name)					-- 品质:1=白色,2=绿色,3=蓝色,4=紫色,5=橙色,6=红色	info.fly_effect_id = tonumber(row.fly_effect_id)				-- 飞行动画ID:填入技能动画表内的ID,技能飞行中的动画	info.front_effect_id = tonumber(row.front_effect_id)			-- 前景动画ID:填入技能动画表内的ID,技能命中后的前景动画	info.back_effect_id = tonumber(row.back_effect_id)				-- 背景动画ID:填入技能动画表内的ID,技能命中后的背景动画	info.caster_buff_id = tonumber(row.caster_buff_id)				-- 自己状态ID	info.caster_buff_rate = row.caster_buff_rate					-- 自己状态几率	info.target_buff_id = tonumber(row.target_buff_id)				-- 目标状态ID	info.target_buff_rate = row.target_buff_rate					-- 目标状态几率	info.damage_type = tonumber(row.damage_type)					-- 伤害模式:伤害结算的模式,1=物理,2=魔法 3=触发其他技能系列	info.skill_cd = tonumber(row.skill_cd)							-- 冷却时间	info.target = tonumber(row.target)								-- 目标:技能对应的目标,1=自己,2=敌方单一目标,3=我方所有目标,4=敌方所有目标,5=画面上所有目标	info.base_damage = row.base_damage								-- 攻击力伤害百分比	info.bonus_damage = row.bonus_damage							-- 附加伤害	info.description = row.description								-- 技能说明	info.effect_mode = row.effect_mode								-- 特效播放模式:defaut=默认,chain=链式,aoe=区域,dash=冲锋	--info.reset_skillkey = CommonFunc_split(row.reset_skillkey,",")					-- 重置技能类型列表    if "0" == row.reset_skillkey then		info.reset_skillkey = {}	else		info.reset_skillkey = CommonFunc_split(row.reset_skillkey, ",")	end	info.increases_blood = row.increases_blood						-- 打中回血     --FIXME 修改字段	info.special_detail = tonumber(row.special_detail)				-- 类型图标    info.skillbuff_hitrate = row.skillbuff_hitrate                  -- 必定命中等级    info.skills_typelist = tonumber(row.skills_typelist)            -- 同一类型技能    info.skill_classification = tonumber(row.skill_classification)    if "0" == row.special_set then      --技能特殊设定		info.special_set = {}	else		info.special_set = CommonFunc_split(row.special_set, ",")	end    info.bestrengthenid =  tonumber(row.bestrengthenid)    info.bestrengthenBuff =  row.bestrengthenBuff	return infoend----------------------------------------------------------------------
local function SpecialSkillsetparseParamer(str)
	local newstr = string.gsub(str, "%s+", "")
	local strTB = {}
	for k, v in string.gmatch(newstr, "([A-Za-z0-9_.+%*-/]*)([,=]?)") do
		if k ~= "" then
			table.insert(strTB, k)
		end
	end
	local paramTB = {}
	local idx = 1
	local total = #strTB
	while true do
		if idx + 1 > total then
			break
		end
		paramTB[strTB[idx]] = strTB[idx + 1]
		idx = idx + 2
	end
	return paramTB
end--沉默对手技能SkillConfig.getSkillCounter = function(skillInfoSpecial_set)     for key,specId in pairs(skillInfoSpecial_set) do         local specInfo = mSkillSpecialSetTB.map[tostring(specId)]        if specInfo.name == "skill_counter" then             local paramTb =  SpecialSkillsetparseParamer(specInfo.param)             local valueTable = 	        {		        {name = "Q", 	value = 1}, --FIXME		        {name = "L", 	value = 1},	        }            local amount = ExpressionParse.compute(paramTb.amount, valueTable)            local rate =  ExpressionParse.compute(paramTb.rate, valueTable)            return rate,amount        end     end end --回血参数转换SkillConfig.getIncreasesBloodInfo = function(skillInfoSpecial_set,quality,level,tanlentLv)    --local skillInfo = SkillConfig.getSkillBaseInfo(skillId)     for key,specId in pairs(skillInfoSpecial_set) do         local specInfo = mSkillSpecialSetTB.map[tostring(specId)]        if specInfo == nil then             cclog("specInfo == nil",specId)            return        end         if specInfo.name == "vampire" then             local paramTb =  SpecialSkillsetparseParamer(specInfo.param)             local valueTable = 	        {		        {name = "Q", 	value = quality or 0}, --FIXME		        {name = "L", 	value = level or 0},                {name = "T", 	value = tanlentLv or 0},	        }            local vampirerate = ExpressionParse.compute(paramTb.vampirerate, valueTable)            local vampirevalue =  ExpressionParse.compute(paramTb.vampirevalue, valueTable)            return vampirerate,vampirevalue,specInfo.description        end     end    return nilend -- 技能召唤参数转换SkillConfig.getSummonInfo = function(skillInfoSpecial_set)    --local skillInfo = SkillConfig.getSkillBaseInfo(skillId)     for key,specId in pairs(skillInfoSpecial_set) do         local specInfo = mSkillSpecialSetTB.map[tostring(specId)]        if specInfo.name == "summon_role" then             local paramTb =  SpecialSkillsetparseParamer(specInfo.param)             local amount = paramTb.amount            local summonid =  paramTb.summonid            return summonid,amount        end     end    return nilend --技能斩杀SkillConfig.getSalyInfo = function(skillInfospecial_set,quality,level,tanlentLv)    --local skillInfo = SkillConfig.getSkillBaseInfo(skillId)     for key,specId in pairs(skillInfospecial_set) do         local specInfo = mSkillSpecialSetTB.map[tostring(specId)]        if specInfo.name == "slay" then             local paramTb =  SpecialSkillsetparseParamer(specInfo.param)              local valueTable = 	        {                {name = "Q",value = quality or 0},		        {name = "L",value = level or 0},                {name = "T",value = tanlentLv or 0},	        }            local belowRate =  ExpressionParse.compute(paramTb.belowRate, valueTable)             local addatkrate = ExpressionParse.compute(paramTb.addatkrate, valueTable)             return belowRate,addatkrate        end     end    return nilend -- 技能重置参数转换SkillConfig.getResetcdInfo = function(skillInfospecial_set,quality,level,tanlentLv)    --local skillInfo = SkillConfig.getSkillBaseInfo(skillId)     for key,specId in pairs(skillInfospecial_set) do         local specInfo = mSkillSpecialSetTB.map[tostring(specId)]        if specInfo.name == "resetcd" then             local rate = math.random(1, 100)            local valueTable = 	        {                {name = "Q",value = quality or 0},		        {name = "L",value = level or 0},                {name = "T",value = tanlentLv or 0},	        }            local _Rate =  ExpressionParse.compute(specInfo.rate, valueTable)             if rate < _Rate then                 local paramTb =  SpecialSkillsetparseParamer(specInfo.param)                 local tb = {}                for key,skilllistid  in pairs(paramTb) do                     table.insert(tb, skilllistid)                end                return tb            end         end     end    return nilend -- buff必定命中等级公式转换SkillConfig.getMustHitLevel = function(skillbuff_hitrate,level)    local valueTable = 	{		{name = "L",value = level},	}	local lv = ExpressionParse.compute(skillbuff_hitrate, valueTable)    return lvend------------------------------------------------------------------------ 获取技能碎片信息SkillConfig.getSkillFragInfo = function(fragID)	local row = XmlTable_getRow(mSkillFragTable, fragID, false)	if nil == row then		return nil	end	local info = {}	info.id = tonumber(row.id)										-- 技能碎片id	info.name = row.name											-- 技能碎片名称	info.role_type = tonumber(row.role_type)						-- 角色类型:1=战士,2=圣骑,3=萨满,4=法师	info.icon = row.icon											-- 图标	info.desc = row.desc											-- 描述	info.skill_id = tonumber(row.skill_id)							-- 技能id	return infoend----------------------------------------------------------------------SkillConfig.getBuffDurtion = function(str,quality,level,tanlentLv)    local valueTable = 	{        {name = "Q",value = quality or 0},		{name = "L",value = level or 0},        {name = "T",value = tanlentLv or 0},	}	local lv = ExpressionParse.compute(str, valueTable)    return lvend-- 获取技能状态信息SkillConfig.getSkillBuffInfo = function(buffID,quality,level,tanlentLv)	local row = XmlTable_getRow(mSkillBuffTable, buffID, false)	if nil == row then		return nil	end	local info = {}	info.buff_id = tonumber(row.buff_id)							-- 状态id	info.buff_name = row.buff_name									-- 状态名	info.buff_type = tonumber(row.buff_type)						-- 状态类型:1=增益,2=减益,3=祝福,4=其他	if "0" == row.buff_icon then		info.buff_icon = nil	else		info.buff_icon = row.buff_icon..".png"						-- 状态图标	end	if "0" == row.shader_name then		info.shader_name = nil	else		info.shader_name = row.shader_name							-- 状态颜色:由程序提供的着色器	end	info.effect_id = tonumber(row.effect_id)						-- 状态调用的技能:在状态结算的时候,可能会调用一个技能,填写技能id	info.duration = SkillConfig.getBuffDurtion(row.duration,quality,level,tanlentLv)							-- 持续时间:技能持续的回合数  改成公式	if "0" == row.modify_attribute then		info.modify_attribute = ""	else		info.modify_attribute = row.modify_attribute				-- 状态改变的属性	end	info.modify_value = row.modify_value							-- 属性改变的数值	info.tips_id = tonumber(row.tips_id)							-- 消息类型ID	info.description = row.description								-- 说明	info.target = tonumber(row.target)								-- 目标:1=技能施放者,2=技能命中的目标    info.buff_replace_type = tonumber(row.buff_replace_type)        -- 顶替类型 相同类型替换掉    info.fold_maxtimes = tonumber(row.fold_maxtimes)                --     info.buff_made = tonumber(row.buff_made)  	return infoend------------------------------------------------------------------------ 获取技能动画信息SkillConfig.getSkillEffectInfo = function(effectID)	local row = XmlTable_getRow(mSkillEffectTable, effectID, false)	if nil == row then		return nil	end	local info = {}	info.effect_id = tonumber(row.effect_id)						-- 动画id	info.file_name = row.file_name									-- 动画使用的文件名:动画图量来自的第一帧	info.string_format = row.string_format							-- 动画格式:动画图量的命名格式	info.image_count = tonumber(row.image_count)					-- 帧数	info.effect_frame_idx = tonumber(row.effect_frame_idx)			-- 第几帧进行数值结算:播放到第几帧播放结算数值的动画	info.plist_name = row.plist_name								-- plist名	info.sound_effect = tonumber(row.sound_effect)					-- 音效	return infoend------------------------------------------------------------------------ 获取技能特效的修正位置SkillConfig.getSkillEffectOffset = function(extsID)	local row = XmlTable_getRow(mSkillEffectExtsTable, extsID, false)	if nil == row then		return 0, 0	end	return tonumber(row.offx), tonumber(row.offy)end------------------------------------------------------------------------ 获取技能升级信息SkillConfig.getSkillUpgradeInfo = function(upgradeID, skillLevel)	local row = XmlTable_getRow(mSkillUpgradeTable, upgradeID*100 + skillLevel, false)	if nil == row then		return nil	end	local info = {}	info.id = tonumber(row.id)										-- 技能升级id	info.level = tonumber(row.level)								-- 技能等级	info.cost = tonumber(row.cost)									-- 升级所需花费	return infoend------------------------------------------------------------------------ 获取技能晋阶信息SkillConfig.getSkillAdvanceInfo = function(advanceID)	local row = XmlTable_getRow(mSkillAdvanceTable, advanceID, false)	if nil == row then		return nil	end	local info = {}	info.id = tonumber(row.id)										-- 技能晋阶id	info.need_ids = tonumber(row.need_ids)							-- 晋阶所需碎片id	info.need_amount = tonumber(row.need_amount)					-- 晋阶所需碎片数量	info.advanced_id = tonumber(row.advanced_id)					-- 下一阶id	return infoend----------------------------------------------------------------------