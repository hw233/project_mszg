--region AINodeDeathWish.lua
--Author : Administrator
--Date   : 2014/12/12

--死亡遗愿

AINodeDeathWish = class(AINodeRole)

function AINodeDeathWish:ctor()
 
   self:setConfig("widget",1)
   self.mConfigTB["interrupt"]  = true --是否打断后续AINODE

   self.mConfigTB["skill_id"]				= 0			--想使用的技能id
end 



function AINodeDeathWish:excultResult()
    local _role = self:getConfig("role")
	local round = BattleMgr.getConfig("bmc_current_round")
    local duration = 0.015

	--死亡结算
end 



--endregion