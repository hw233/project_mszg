﻿------------------------------------------------------------------------ 作者：lewis-- 日期：2013-3-31-- 描述：结点使用aoe技能----------------------------------------------------------------------NodeSkillAOE = class(NodeUseSkill)--构造function NodeSkillAOE:ctor()	self.mSpecialCnt = {}	self.mSpecialCnt["boss"] = 0end	--计算权值function NodeSkillAOE:calc()	--已经开门了,不再攻击怪物	if AIMgr.getEnvir("is_door_open") then		return	end		self:evalCommon()	local total = 0	local tb = RoleMgr.getConfig("rmc_monster_table")	local monsterCount = 0	for kev, monster in pairs(tb) do		if monster:isAlive() then			monsterCount = monsterCount + 1			local eval = MonsterHatred.getHatredWithType("aoe", monster)			total = total + eval		end	end	local expectation = math.random(2, 3)	--有boss存在时,不再期盼攻击多个怪物	if AIMgr.getEnvir("boss") > 0 then		expectation = 1	end	local dis = monsterCount - expectation	if dis >= 0 then		total = total + 10	elseif dis == -1 then		total = total * 0.7	else		total = total * 0.3	end	self.mEvaluation = self.mEvaluation + totalend