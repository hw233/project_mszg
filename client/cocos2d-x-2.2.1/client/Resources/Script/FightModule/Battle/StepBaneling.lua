﻿------------------------------------------------------------------------ 作者：lewis-- 日期：2013-4-4-- 描述：自爆动作----------------------------------------------------------------------StepBaneling = class(BattleStep)--构造function StepBaneling:ctor()	self.mRole 		= nil		--自爆角色end--初始化function StepBaneling:init(role)	self.mRole = roleend--执行对应的操作function StepBaneling:excute()	self.mRole:changeAnimateState("baneling")end