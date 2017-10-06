﻿------------------------------------------------------------------------ 作者：lewis-- 日期：2013-04-11-- 描述：竞技场敌人格子----------------------------------------------------------------------GridEnemy = class(GridMonster)--构造function GridEnemy:ctor()	self.mEnenmyInfo = nilend--绑定数据function GridEnemy:bindData(data)	self.mEnenmyInfo = data	--预加载怪物资源	FightConfig.setConfig("fc_enemy_role_type", data.type)	FightResLoader.preloadEnemyRes(data)end--开始运作，等待事件function GridEnemy:run()    if FightDateCache.getData("fd_game_mode") == 5  then          --队长先亮出来其他翻出来        if self.mEnenmyInfo.id_leader == 1 then  	        self:openGrid()	        self:effectRemoveBg()            --self:openFogMask()            --self:lightupAround()	        self:showMonster()        end     else         self:openGrid()
	    self:effectRemoveBg()
	    self:showMonster()    endend--激活敌人
function GridEnemy:activeEnemy()
	--把敌人设成主动怪
    if FightDateCache.getData("fd_game_mode") ~= 5 then 
        print("----------------激活主动怪-------------------")
	    local enemy = RoleMgr.getMonsterByGridId(self:getConfig("grid_id"))
	    if enemy == nil then
		    return
	    end
	    enemy:setConfig("attack_type", 1)
    end
end--显示出怪物function GridEnemy:showMonster()	self:setConfig("event_name", "monster")	local pos = self:getPosition()	pos.y = pos.y - 50	self.mMonsterRole = RoleMgr.createEnemy(self:getConfig("grid_id"), pos, self.mEnenmyInfo)end--激活敌人function GridEnemy:activeEnemy()	--把敌人设成主动怪	local enemy = RoleMgr.getMonsterByGridId(self:getConfig("grid_id"))    if enemy == nil then		return	end	enemy:setConfig("attack_type", 1)end--外部触发事件function GridEnemy:onEvent()	if self:getConfig("is_invalid") then return end	--打开格子	if self:getConfig("is_opened") == false then		--周边有怪物或被迷雾遮罩		if self:isCanOpened() == false then 			GridMgr.setConfig("gmc_touch_effect", false)			return 		end		self:openGrid()		self:openFogMask()		self:effectRemoveBg()		self:showMonster()		--self:guardAction(true)        self:triggerNextRound()        local effect = EffectRoundflag.new()        if self.mMonsterRole:getConfig("role_group_id") == 0 then             effect:init("myround_add")        else             effect:init("enemy_add")        end         effect:play()		return	end		--开始战斗	if self.mMonsterRole ~= nil and self.mMonsterRole:isAlive() then        if self.mMonsterRole:getConfig("role_group_id") ~= 0 then 		    BattleMgr.attackMonster(self:getConfig("grid_id"), self:getConfig("is_mask"))        end 	endend--怪物被K.Ofunction GridEnemy:knockout(summonId, bBody)	self:setConfig("event_name", "none")	self:effectKnockout()	self:effectShowBody()	    local killEnemyNumber =  RoleMgr.getConfig("kill_enemy_number")     local killFriendNumber = RoleMgr.getConfig("kill_friend_number")    	--local enemy = RoleMgr.getSummonMonsterByGridId(gridId,self.mMonsterRole:getConfig("role_group_id"))    local group =  self.mMonsterRole:getConfig("role_group_id")--组别id,0是玩家方,1是怪物    if group == 1 then         RoleMgr.setConfig("kill_enemy_number",killEnemyNumber+1)              if self.mMonsterRole:getConfig("is_leader") == 1 then  --默认为0,1表示团长             RoleMgr.setConfig("is_enemy_bekill",true)         end         if self.mMonsterRole.mEnemyInfoView ~=nil then             self.mMonsterRole.mEnemyInfoView:beKilled()        end     elseif group == 0 then         RoleMgr.setConfig("kill_friend_number",killFriendNumber+1)         local friendBeKilllist = RoleMgr.getConfig("friend_beKilllist")         table.insert(friendBeKilllist,self.mMonsterRole:getConfig("serve_role_id"))    end 	local effect = EffectBattleEnd.new()	effect:init("enemy_knock_out")	effect:play()end--长按事件function GridEnemy:onPress()	--怪物不存在了	if self:getConfig("event_name") == "none" then		return	end	local monster = self.mMonsterRole	if monster == nil then		return	end	local tb = {}	tb.gridId = self:getConfig("grid_id")    tb.camp = self.mMonsterRole:getConfig("role_group_id")	UIManager.push("UI_MonsterInfo", tb)end