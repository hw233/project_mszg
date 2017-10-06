﻿------------------------------------------------------------------------ 作者：lewis-- 日期：2013-04-11-- 描述：格子基类----------------------------------------------------------------------Grid = class()--构造function Grid:ctor(tag)	self.mConfigTB	= {}	--基本数据    self.mConfigTB["has_open"]				= false		--是否被预先打开 格子动画专用	self.mConfigTB["grid_id"]				= 0			--格子id	self.mConfigTB["x_index"]				= 0			--x索引	self.mConfigTB["y_index"]				= 0			--y索引		self.mConfigTB["position"]				= nil		--位置	self.mConfigTB["user_data"]				= nil		--用户数据	self.mConfigTB["tag"]					= tag		--tag,标明是什么格子		self.mConfigTB["is_mask"]				= true		--是否在遮罩中	self.mConfigTB["is_opened"]				= false		--是否已被打开	self.mConfigTB["is_invalid"]			= false		--是否是无效的格子,指不会有任何事件产生的格子	self.mConfigTB["monster_around_cnt"]	= 0			--周边怪物个数	self.mConfigTB["wait_for_clean_fog"]	= false		--是否等待打开迷雾	self.mConfigTB["isBright"]   			= false     --是否为发亮状态		self.mConfigTB["event_name"]			= "none"	--当前格子上的事件,如有怪物monster,blood_bottle有血瓶,coins有金币,door打开了的门	--视图	self.mConfigTB["sprite_fog_mask"]		= nil		--迷雾遮罩	self.mConfigTB["sprite_limit_mask"]		= nil		--X限制遮罩	self.mConfigTB["sprite_bg_mask"]		= nil		--底图遮罩    self.mConfigTB["sprite_monster_body"]   = nil       --		self.mConfigTB["search_tag"]			= true		--搜索标记	self.mConfigTB["has_key"]				= false		--是否有钥匙	self.mConfigTB["is_trigger_new_round"]	= true		--开格子时是否触发新回合	self.mConfigTB["enable_force_open"]		= true		--是否可以强制打开		self.mConfigTB["is_summon_monster"]		= false		--是否是召唤的怪物    self.mConfigTB["refences_id"]           = 0 end-----------------------------------------------------------------------------------------------------------数据配置----------------------------------------------------------------------------------------------------------------拷贝数据function Grid:copy(newGrid)	for key, value in pairs(self.mConfigTB) do		newGrid.mConfigTB[key] = value	end    --cleanup body    local sprite = newGrid:getConfig("sprite_monster_body")    if sprite then        sprite:removeFromParentAndCleanup(true)        newGrid:setConfig("sprite_monster_body", nil)    endend--获得数据function Grid:getConfig(name)	local ret = self.mConfigTB[name]	return retend--设置数据function Grid:setConfig(name, value)	self.mConfigTB[name] = valueend--是否可以打开的格子function Grid:isCanOpened()	--是否已打开	if self:getConfig("is_opened") == true  then		return false	end	--是否在遮罩中或周边有怪物	if self:getConfig("is_mask") or self:getConfig("monster_around_cnt") > 0 then		return false	end	return trueend--绑定数据function Grid:bindData(data)end--获取位置function Grid:getPosition()	local pos = self:getConfig("position")	return ccp(pos.x, pos.y)end--获取中间位置function Grid:getMiddlePos()	local pos = self:getConfig("position")	return ccp(pos.x, pos.y + 50)end-----------------------------------------------------------------------------------------------------------多态接口----------------------------------------------------------------------------------------------------------------关门function Grid:closeDoor()end--开门function Grid:openDoor()end--激活敌人function Grid:activeEnemy()end--怪物被K.Ofunction Grid:knockout(summonId, bBody)endfunction Grid:separate()end--开始运作，等待事件function Grid:run()endfunction Grid:onTap()    if self:isCanOpened() == true then -- and FightDateCache.getData("fd_game_mode") == 5        if self:getConfig("has_open") == true then  
            cclog("格子被提前打开", self:getConfig("grid_id"))
            return
        else 
           self:setConfig("has_open",true)
        end 	    BattleMgr.playerOpenGrid(self:getConfig("grid_id"))    else        self:onEvent()    endend--外部触发事件function Grid:onEvent()end--长按事件function Grid:onPress()end--开格子触发下一回合function Grid:triggerNextRound()	if self:getConfig("is_trigger_new_round") == false then		return	end	GuideEvent.openGrid()	--BattleMgr.playerOpenGrid()end--是否要高亮提示function Grid:isHighLightTips()	return self:isCanOpened()end-----------------------------------------------------------------------------------------------------------功能函数----------------------------------------------------------------------------------------------------------------移除迷雾遮罩特效function Grid:effectRemoveFogMask()	self:activeEnemy()	self:setConfig("is_mask", false)	self:getConfig("sprite_fog_mask"):runAction(CCFadeOut:create(0.4))end--打开迷雾遮罩function Grid:openFogMask()	--打开自身的迷雾	if self:getConfig("is_mask") then		self:effectRemoveFogMask()	end	self:lightupAround()end--打开周边遮罩function Grid:lightupAround()	local idx = self:getConfig("x_index")	local idy = self:getConfig("y_index")	for dir = 1, 4 do		local around = GridMgr.traversalByFourDir(idx, idy, dir)		if around ~= nil and around:getConfig("is_mask") then			if around:getConfig("wait_for_clean_fog") then				around:setConfig("wait_for_clean_fog", false)				around:lightupAround()			end			around:effectRemoveFogMask()		end	endend--激活X限制function Grid:guardAround()	if self:getConfig("is_opened") then		return	end	local sprite = self:getConfig("sprite_limit_mask")	if sprite == nil then		local batchNode = GridMgr.getConfig("gmc_x_batch_node")		sprite = CCSprite:createWithTexture(batchNode:getTexture())		batchNode:addChild(sprite)		sprite:setPosition(self:getConfig("position"))		self:setConfig("sprite_limit_mask", sprite)				sprite:setVisible(true)		sprite:setScale(0.0)		sprite:runAction(CCScaleTo:create(0.2, 1.0))	else		sprite:setVisible(true)		sprite:stopAllActions()		sprite:runAction(CCScaleTo:create(0.2, 1.0))	end	--周边怪物个数+1	local monsterCnt = self:getConfig("monster_around_cnt")	monsterCnt = monsterCnt + 1	self:setConfig("monster_around_cnt", monsterCnt)end--取消X限制function Grid:cancelGuard()	local monsterCnt = self:getConfig("monster_around_cnt")	if monsterCnt == 0 then		return	end	monsterCnt = monsterCnt - 1	self:setConfig("monster_around_cnt", monsterCnt)	--关闭x	local sprite = self:getConfig("sprite_limit_mask")	if monsterCnt <= 0 and sprite ~= nil then        self:setConfig("has_open",false)    --点快有可能 出现BUG		sprite:stopAllActions()		local arr = CCArray:create()		arr:addObject(CCScaleTo:create(0.2, 0.0))		arr:addObject(CCHide:create())		sprite:runAction(CCSequence:create(arr))	endend--守护或取消守护周边格子function Grid:guardAction(bActive)	local idx = self:getConfig("x_index")	local idy = self:getConfig("y_index")	for dir = 1, 8 do		local around = GridMgr.traversalByEightDir(idx, idy, dir)		if around ~= nil then			if bActive then				around:guardAround()			else				around:cancelGuard()			end		end	endend--普通打开格子,画面表现function Grid:effectRemoveBg()	SoundDispath.openGrid(0)	local layer = GridMgr.getConfig("gmc_effect_layer")	local sprite = FightAnimationMgr.gridEffectOnce("openmask_%02d.png", 10, 0.05)--播放破坏箱子特效	layer:addChild(sprite)	sprite:setPosition(self:getConfig("position"))	sprite:setAnchorPoint(ccp(0.5,0.5))end--打开格子,数值逻辑操作function Grid:openGrid()	self:setConfig("is_opened", true)	self:getConfig("sprite_bg_mask"):setVisible(false)end--强行打开格子function Grid:forceOpenGrid()	if self:getConfig("is_opened") then		return	end	if self:getConfig("has_open") then		return	end	--取消X限制	if self:getConfig("monster_around_cnt") > 0 then		self:setConfig("monster_around_cnt", 1)		self:cancelGuard()	end	if self:getConfig("is_mask") then		self:effectRemoveFogMask()		self:setConfig("is_mask", false)	end	self:setConfig("is_trigger_new_round", false)	self:onEvent()	self:setConfig("is_trigger_new_round", true)end