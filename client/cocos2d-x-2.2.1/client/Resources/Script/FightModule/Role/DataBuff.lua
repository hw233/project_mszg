------------------------------------------------------------------------ 作者：lewis-- 日期：2013-3-31-- 描述：角色buff数据----------------------------------------------------------------------DataBuff = class()local function newBuffUnit()	local unit = {}	unit.shader			= nil	unit.quality 		= 1	unit.level 			= 1	unit.id 			= 0	unit.icon 			= nil	unit.duration 		= 0	unit.shader 		= nil	unit.modifyTB 		= {}	unit.crit_ratio 	= 0    --unit.modifyAttribute = ""    --unit.modifyValue     = 0    --unit.isPercentage    = false	return unitend--构造function DataBuff:ctor()	self.units = {}	self.units[1] = newBuffUnit()	--增益	self.units[2] = newBuffUnit()	--减益	self.units[3] = newBuffUnit()	--友军光环	self.units[4] = newBuffUnit()	--祝福	self.units[5] = newBuffUnit()	--虚弱光环	self.mAttribute		= nil		--对应的基本数据	self.mStatus		= nil	self.mSkill			= nilendfunction DataBuff:init(attribute, status, skill)	self.mAttribute		= attribute		--对应的基本数据	self.mStatus		= status	self.mSkill			= skillend--激活虚弱光环function DataBuff:activeWeakHalo(id, quality, level)	local config = SkillConfig.getSkillBuffInfo(id)	if config == nil then 		return nil	end	local nameStr = config.modify_attribute	local valueStr = config.modify_value	local unit = self.units[5]	unit.id			= id	unit.quality 	= quality	unit.level 		= level	unit.duration = config.duration	SkillMgr.parseStatusString(unit.modifyTB, nameStr, valueStr, quality, level,self:getBuffConfig("buff_made"),self:getBuffConfig("talentlv"))end--光环function DataBuff:activeHalo(id, quality, level)    local config = SkillConfig.getSkillBuffInfo(id)	if config == nil then 		return nil	end	local nameStr = config.modify_attribute	local valueStr = config.modify_value	local unit = self.units[3]	unit.id			= id	unit.quality 	= quality	unit.level 		= level	unit.duration = config.duration	SkillMgr.parseStatusString(unit.modifyTB, nameStr, valueStr, quality, level,self:getBuffConfig("buff_made"),self:getBuffConfig("talentlv"))end--激活buff--[[function DataBuff:activeHalo(id, quality, level)	local config = SkillConfig.getSkillBuffInfo(id)	if config == nil then 		return nil	end	local nameStr = config.modify_attribute	local valueStr = config.modify_value	local unit = self.units[3]	unit.id			= id	unit.quality 	= quality	unit.level 		= level	unit.duration = config.duration	SkillMgr.parseStatusString(unit.modifyTB, nameStr, valueStr, quality, level)end]]----激活bufffunction DataBuff:active(id, quality, level)	local config = SkillConfig.getSkillBuffInfo(id)	if config == nil then 		return nil	end	local idx = 0	local nameStr = config.modify_attribute	local valueStr = config.modify_value	if config.duration <= 0 then--光环效果		local unit = self.units[3]		unit.id			= id		unit.quality 	= quality		unit.level 		= level		unit.duration = config.duration		SkillMgr.parseStatusString(unit.modifyTB, nameStr, valueStr, quality, level,self:getBuffConfig("buff_made"),self:getBuffConfig("talentlv"))		return	else		idx = config.buff_type	end	--清除旧的状态	self:stop(idx)	local unit = self.units[idx]	unit.shader		= config.shader_name	unit.icon		= config.buff_icon	unit.id			= id	unit.quality 	= quality	unit.level 		= level	unit.duration = config.duration	SkillMgr.parseStatusString(unit.modifyTB, nameStr, valueStr, quality, level,self:getBuffConfig("buff_made"),self:getBuffConfig("talentlv"))	self:start(idx)end--激活buff后,马上结算的bufffunction DataBuff:afterActiveBuff()	--是否存在净化术	if self.mStatus:getStatus("cleaned") == true then		self:stop(2)	end		--是否技能重新冷却	if self.mStatus:getStatus("max_cd") == true then		self.mSkill:onStep("max_cd")	endend--改变基础数据,不改变生命值function DataBuff:modifyAttribute(tb, bOn)	for key, value in pairs(tb) do		if value.modifyAttribute ~= "life" then			self.mAttribute:modifiedByName(value.modifyAttribute, value.modifyValue, value.isPercentage, bOn)		end	endend--改变状态function DataBuff:modifyStatus(tb, bOn)	for key, value in pairs(tb) do		local status = self.mStatus:getStatus(value.modifyAttribute)		if status ~= nil then			if type(status) == "number" then				local data = bOn and value.modifyValue or 0				self.mStatus:setStatus(value.modifyAttribute, data)			else				self.mStatus:setStatus(value.modifyAttribute, bOn)			end		end	endend--buff对生命修改的效果function DataBuff:lifeEffect()	local life = 0	for i = 1, 2 do		local unit = self.units[i]		for key, value in pairs(unit.modifyTB) do			if value.modifyAttribute == "life" then				local v = self.mAttribute:calcModifiedValue("life", value.modifyValue, value.isPercentage)				life = life + v			end		end	end	--return math.random(-100, 100)	return lifeend--buff开启function DataBuff:start(idx)	self:modifyAttribute(self.units[idx].modifyTB, true)	self:modifyStatus(self.units[idx].modifyTB, true)end--buff结束function DataBuff:stop(idx)	local unit = self.units[idx]	self:modifyAttribute(unit.modifyTB, false)	self:modifyStatus(unit.modifyTB, false)	unit.id			= 0	unit.duration 	= 0	unit.shader		= nil	unit.modifyTB	= {}end--获得shaderfunction DataBuff:getShader()	local shader = nil	for i = 1, 2 do		local unit = self.units[i]		shader = unit.shader	end	return shaderendfunction DataBuff:onStep()	for i = 1, 2 do		local unit = self.units[i]		if unit.duration > 0 then			unit.duration = unit.duration - 1		end		if unit.duration == 0 then			self:stop(i)		end	endend--是否有DEBUFFfunction DataBuff:isDebuff()    --FIXMEBUFF    local unit = self.units[2]	if unit.duration > 0 then		return true	end    return falseend--强制清除bufffunction DataBuff:cleanupAll()	for i = 1, 2 do		local unit = self.units[i]		if unit.duration > 0 then			unit.duration = 0		end		if unit.duration == 0 then			self:stop(i)		end	endend--光环效果function DataBuff:onHalo(caster, bOn, idx)	idx = idx or 3	--不给自己上光环	--if caster == self then	--	return	--end	local unit = caster.units[idx]	if unit.id == 0 then		return	end	self:modifyAttribute(caster.units[idx].modifyTB, bOn)	self:modifyStatus(caster.units[idx].modifyTB, bOn)end