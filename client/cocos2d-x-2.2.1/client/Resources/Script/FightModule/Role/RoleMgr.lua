﻿------------------------------------------------------------------------ 作者：lewis-- 日期：2013-3-31-- 描述：角色管理器----------------------------------------------------------------------require "ActionSprite"require "DataAttribute"require "DataBuff"  --FIMBUFFrequire "DataSkill"require "DataStatus"require "talentMgr"require "BuffMgr"require "RoleData"require "Role"require "RolePlayer"require "RoleMonster"require "RoleTotem"require "RoleFriend"require "RoleEnemy"require "RoleBoss"require "RoleSummon"require "PlayerSkillBtn"require "RoleInfoView"require "PlayerInfoView"require "MonsterInfoView"require "EnemyInfoView"require "BossInfoView"require "RoleAction"RoleMgr = {}local mConfigTB = {}function RoleMgr.init()	RoleMgr.initConfig()endfunction RoleMgr.cleanup()	local tb = RoleMgr.getConfig("rmc_monster_table")	if tb then		for key, value in pairs(tb) do			if value:isAlive() then				value:cleanup()			end		end	end	local player = RoleMgr.getConfig("rmc_player_object")	if player then		player:cleanup()	end	mConfigTB = {}endfunction RoleMgr.reset()    --reset monstertable	local monsterTB = RoleMgr.getConfig("rmc_monster_table")	if monsterTB then		for key, value in pairs(monsterTB) do			if value:isAlive() then                local buffTb = value:getDataInfo("buff")                for key,buff in pairs (buffTb) do                     if buff:getBuffConfig("buff_type") == 4 and buff:getBuffConfig("target") == 4 then                         RoleMgr.removePlayDeHalo(buff)                      end                 end 				value:cleanup()			end		end	end	RoleMgr.setConfig("rmc_monster_table", {})    --reset playertable    local playerTB = RoleMgr.getConfig("rmc_player_table")    for key,role in pairs(playerTB) do 			if role:isAlive() and RoleMgr.getConfig("rmc_player_object")~= role then                local buffTb = role:getDataInfo("buff") or {}                for key,buff in pairs (buffTb) do                     if buff:getBuffConfig("buff_type") == 4 and buff:getBuffConfig("target") == 4 then                         RoleMgr.removePlayDeHalo(buff)                      end                 end 				--RoleMgr.startHaloForPlayer(value, false)				role:cleanup()			end    end     RoleMgr.setConfig("rmc_player_table", {})    table.insert(  RoleMgr.getConfig("rmc_player_table"),RoleMgr.getConfig("rmc_player_object"))		local totemTB = RoleMgr.getConfig("rmc_totem_table")	if totemTB then		for key, value in pairs(totemTB) do			if value:isAlive() then				value:cleanup()			end		end	end	RoleMgr.setConfig("rmc_totem_table", {})end-----------------------------------------------------------------------------------------------------------配置数据----------------------------------------------------------------------------------------------------------------初始化配置数据function RoleMgr.initConfig()	mConfigTB = {}	mConfigTB["rmc_player_parent_layer"]				= nil		--玩家的父结点	mConfigTB["rmc_monster_parent_layer"]				= nil		--怪物的父结点	mConfigTB["rmc_monster_info_parent_layer"]			= nil		--怪物属性视图父结点	mConfigTB["rmc_player_skill_btn_layer"]				= nil		--技能按钮父结点	mConfigTB["rmc_player_skill_btn_tb"]				= {}	mConfigTB["rmc_player_object"]						= nil		--玩家对象	mConfigTB["rmc_player_table"]						= {}		--玩家方列表	mConfigTB["rmc_monster_table"]						= {}		--怪物列表	mConfigTB["rmc_totem_table"]						= {}		--图腾表	mConfigTB["rmc_friend_object"]						= nil		--友军对象	--mConfigTB["rmc_enemy_object"]						= nil		--竞技场敌人对象    mConfigTB["kill_enemy_number"]                      = 0         --杀死敌人的数量    mConfigTB["kill_friend_number"]                     = 0         --杀死我方人数的数量    mConfigTB["friend_beKilllist"]                      = {}        --我方被杀的队列    mConfigTB["is_enemy_bekill"]                        = false     --敌方队长是否被杀死    mConfigTB["enemy_index"]                            = 0         --敌人索引    mConfigTB["jjc_friend_lifeInfo"]                    = {}        --我方所有生命值	end--获得数据function RoleMgr.getConfig(name)	local ret = mConfigTB[name]	return retend--设置数据function RoleMgr.setConfig(name, value)	mConfigTB[name] = valueend-----------------------------------------------------------------------------------------------------------角色创建----------------------------------------------------------------------------------------------------------------创建玩家function RoleMgr.createPlayer()	local tb = RoleMgr.getConfig("rmc_player_table")	local player = RolePlayer.new()    table.insert(tb, player)	player:init(ccp(80, 10))	player:setConfig("role_group_id", 0)	player:setConfig("role_side_id", 0)	RoleMgr.setConfig("rmc_player_object", player)end--创建怪物function RoleMgr.createMonster(gridId, pos, monsterid)    local tb = RoleMgr.getConfig("rmc_monster_table")	local monster = RoleMonster.new()    table.insert(tb, monster)	monster:init(gridId, pos, monsterid)		--开启光环    RoleMgr.acceptHaloFromOtherRole(monster)		--偷取金币初始化    monster:initStealCoin()	return monsterend--创建召唤物体function RoleMgr.createSummon(gridId, pos, summonId,skilllevel,caster)	if caster == nil then		return	end    local roleCamp = caster:getConfig("role_group_id")    local level = caster:getConfig("role_level")    local summoner = RoleSummon.new()    if roleCamp == 0 then --我方        local tb = RoleMgr.getConfig("rmc_player_table")         table.insert(tb, summoner)    elseif roleCamp == 1 then --敌方        local tb = RoleMgr.getConfig("rmc_monster_table")		table.insert(tb, summoner)		    end     summoner:init(gridId, pos, summonId,roleCamp,skilllevel,level)    --开启光环    RoleMgr.acceptHaloFromOtherRole(summoner)    --偷取金币init    summoner:initStealCoin()    return summonerend --创建BOSSfunction RoleMgr.createBoss(gridId, pos, monsterid)    local tb = RoleMgr.getConfig("rmc_monster_table")    local monster = RoleBoss.new()	table.insert(tb, monster)    monster:setConfig("role_group_id", 1)	monster:setConfig("role_side_id", 1)	monster:init(gridId, pos, monsterid)		--开启光环    RoleMgr.acceptHaloFromOtherRole(monster)		--偷取金币	local rate = monster:getConfig("steal_coin_rate")	local total = FightDateCache.getData("fd_coin_count")	local coins = math.ceil(total * rate)	total = total - coins	FightDateCache.setData("fd_coin_count", total)	if coins > 0 then		monster:setConfig("drop_out_coins", coins)		local effect = EffectStealConis.new()		effect:init(coins, monster:getMiddlePos())		effect:play()	end	return monsterend--创建援军function RoleMgr.createFriend()	local roletype = FightDateCache.getData("fd_friend_role_type")	if roletype == 0 then		return	end	local role_tplt = ModelPlayer.getRoleUpAppence(roletype, 1)	local friend = RoleFriend.new()	friend:init(role_tplt.icon)	RoleMgr.setConfig("rmc_friend_object", friend)end--创建竞技场敌人function RoleMgr.createEnemy(gridId, pos, enemyInfo)	local enemy = RoleEnemy.new()    enemy:setConfig("role_group_id", enemyInfo.team_tag)	enemy:setConfig("role_side_id", enemyInfo.team_tag )	enemy:init(gridId, pos, enemyInfo)	local enemytb = RoleMgr.getConfig("rmc_monster_table")    local frienttb = RoleMgr.getConfig("rmc_player_table")    if enemyInfo.team_tag == 1 then         table.insert(enemytb, enemy)    else        table.insert(frienttb, enemy)    end 	--RoleMgr.setConfig("rmc_enemy_object", enemy)	return enemyend--创建图腾function RoleMgr.createTotem(gridId, pos, skillId, argsStr)	local totem = RoleTotem.new()	totem:init(gridId, pos, skillId, argsStr)	local tb = RoleMgr.getConfig("rmc_totem_table")	table.insert(tb, totem)end-----------------------------------------------------------------------------------------------------------角色管理----------------------------------------------------------------------------------------------------------------通过格子id获得怪物function RoleMgr.getMonsterByGridId(gridId)	local tb = RoleMgr.getConfig("rmc_monster_table")	for key, value in pairs(tb) do		if value:compareByGridId(gridId) then			return value		end	end	return nilend--通过格子id 和 阵营  获取召唤怪function RoleMgr.getSummonMonsterByGridId(gridId,camp)	local tb = nil     if camp == 0 then         tb = RoleMgr.getConfig("rmc_player_table")      elseif camp == 1 then         tb = RoleMgr.getConfig("rmc_monster_table")    end	for key, value in pairs(tb) do		if value:compareByGridId(gridId) then			return value		end	end	return nilend--获得怪物个数function RoleMgr.getMonsterCnt()	local cnt = 0	local tb = RoleMgr.getConfig("rmc_monster_table")	for key, value in pairs(tb) do		if value:isAlive() then			cnt = cnt + 1		end	end	return cntend--移除怪物--[[function RoleMgr.removeMonster(gridId)	local tb = RoleMgr.getConfig("rmc_monster_table")	for key, value in pairs(tb) do		if value:compareByGridId(gridId) then			table.remove(tb, key)			return		end	endend]]----移除角色function RoleMgr.removeRole(_role)    local roleCamp = _role:getConfig("role_group_id")    local playerRole =  RoleMgr.getConfig("rmc_player_object")     local tb = {}
    if roleCamp == 0 then
        tb =  RoleMgr.getConfig("rmc_player_table")  
    elseif roleCamp == 1 then 
        tb = RoleMgr.getConfig("rmc_monster_table")
    end     if playerRole == _role then 
       for key, value in pairs(tb) do
           if value == _role then 
            table.remove(tb, key)
            return
            end 
        end
     end     for key, value in pairs(tb) do		if value:compareByGridId(_role.mGridId) then            cclog("移除role数据！！",roleCamp,_role.mGridId)			table.remove(tb, key)			return		end	endend --怪物出现 要接受 其他光环怪bufffunction RoleMgr.acceptHaloFromOtherRole(accepter)    local ground = accepter:getConfig("role_group_id")     --组别id,0是玩家,1是怪物    --target：作用类型 3-我方所有目标 4-敌方所有目标    local function traverseRoleBuff(_roleTb,_target)        for key,role in pairs(_roleTb) do             local buffTb =  role:getDataInfo("buff")            for key,buff in pairs(buffTb) do                 if  buff:getBuffConfig("buff_type") == 4 and  buff:getBuffConfig("target") == _target and accepter ~= role then                     accepter:acceptHalo(buff,true)                end             end         end     end     --玩家获取光环buff    if ground == 0 then --是玩家        --增益        traverseRoleBuff(RoleMgr.getConfig("rmc_player_table"),3)        --减益        traverseRoleBuff(RoleMgr.getConfig("rmc_monster_table"),4)    elseif ground == 1 then --是怪物        --增益        traverseRoleBuff(RoleMgr.getConfig("rmc_monster_table"),3)        --减益        traverseRoleBuff(RoleMgr.getConfig("rmc_player_table"),4)    end end function RoleMgr.removeOtherHalo(caster)    local ground = caster:getConfig("role_group_id")     local buffTB = caster:getDataInfo("buff")    for key,buff in pairs(buffTB) do         if buff:getBuffConfig("buff_type") == 4  then             local roleTb = chooseImpactRoles(ground,buff:getBuffConfig("target"))                    for key,role in pairs(roleTb) do                  if caster ~= role and role:isAlive() == true then                     role:acceptHalo(buff,false)                 end             end         end    endend --为玩家上虚弱光环--[[function RoleMgr.startHaloForPlayer(caster, bOn)	local player = RoleMgr.getConfig("rmc_player_object")	player:acceptHalo(caster, bOn, 5)end]]----强制移除玩家身上的光环function RoleMgr.removePlayDeHalo(buff)    local player = RoleMgr.getConfig("rmc_player_object")    player:acceptHalo(buff,false)end --随机获得一只存活的怪物function RoleMgr.getRandomMonster()	local tb = RoleMgr.getConfig("rmc_monster_table")	local rand = math.random(1, #tb)	local idx = 1	for key, monster in pairs(tb) do		if monster:isAlive() and math.abs(rand - idx) < 3 then			return monster		end		idx = idx + 1	end	return nilend--移除图腾function RoleMgr.removeTotem(role)	local tb = RoleMgr.getConfig("rmc_totem_table")	for key, value in pairs(tb) do		if value == role then			table.remove(tb, key)			return		end	endend--是援军技能就缩进去function RoleMgr.useSkill(caster, id)	local groupId = caster:getConfig("role_group_id")--组别id,0是玩家,1是怪物	if groupId == 2 then		AssistanceViewController.useSkill() 	endend--是否锁定怪物function RoleMgr.aimedMonster(bOn)	local tb = RoleMgr.getConfig("rmc_monster_table")	for key, monster in pairs(tb) do		if monster:isAlive() then			if bOn then				monster:changeAnimateState("aimed")			else				monster:changeAnimateState("dis_aimed")			end		end	endend--清除分身function RoleMgr.cleanupIllusion(id)    local tb = RoleMgr.getConfig("rmc_monster_table")    while true do        local bBreak = true	    for key, monster in pairs(tb) do		    if monster:isAlive() then			    if id == monster:getConfig("real_body_id") then                    monster:cleanupIllusion()                    bBreak = false                end		    end	    end        if bBreak then            break        end    endend-----------------------------------------------------------------------------------------------------------玩家外部接口------------------------------------------------------------------------------------------------------------通过索引获得技能按钮位置function RoleMgr.getSkillBtnPosByIdx(idx)	if 5 == idx then	-- 援军技能		local assistBtn = AssistanceViewController.getConfig("skill_btn")		if nil == assistBtn then			return ccp(0, 0)		end		return ccpAdd(assistBtn.mBtnSkill:getWorldPosition(), ccp(47, 47))	end	local tails = {"ImageView_28_0", "ImageView_28_1", "ImageView_28_2", "ImageView_28"}	local bgImage = tolua.cast(LayerGameUI.mRootView:getWidgetByName(tails[idx]), "UIImageView")	local pos = bgImage:getWorldPosition()	return posendfunction RoleMgr.getPlayerLife()	local player = RoleMgr.getConfig("rmc_player_object")	local attribute = player.mData.mAttribute	local life = attribute:getByName("life")	local maxlife = attribute:getMaxAttrWithName("life")	return life, maxlifeend--玩家复活function RoleMgr.playerRespawn()	local player = RoleMgr.getConfig("rmc_player_object")	player:respawn()end--获取玩家按钮function RoleMgr.getPlayerSkillBtn(idx)	local player = RoleMgr.getConfig("rmc_player_object")	local infoView = player.mInfoView	local tb = infoView.mSkillBtnTB	return tb[idx]end--是否可以点技能按钮function RoleMgr.isTouchEnable()	local player = RoleMgr.getConfig("rmc_player_object")	if player == nil then		return false	end	if player:isAlive() == false then		return false	end	if player:isCommonAttackValid() == false then		return false	end	return trueend--role被击杀释放技能function RoleMgr.beKOcastSkill(defener,attacker,timer,othertimes)	--被击者被K.O后触法技能	if defener:isAlive() == false then       if talentMgr.excultOnEvent(defener,"onDying",nil) == nil then 			local id = defener:getConfig("skill_after_death")			if id ~= 0  and defener:getConfig("explosive_round") == 0 then				defener:setConfig("death_display_mode", "baneling")                defener:setConfig("skill_after_death", 0)				local dt = timer + othertimes				MagicAttack.fight(defener, attacker, id, level,dt)			end        end 	endend ---竞技场专用function RoleMgr.addFriendLifeInfo(enemyInfo)    local lifelist =  RoleMgr.getConfig("jjc_friend_lifeInfo")     local lifeInfo = role_life_info()    if enemyInfo.team_tag == 0 then        lifeInfo.role_id = enemyInfo.role_id        lifeInfo.cur_life =enemyInfo.cur_life        table.insert(lifelist, lifeInfo)    end end function RoleMgr.addPlayerLifeInfo()    local lifelist =  RoleMgr.getConfig("jjc_friend_lifeInfo")     local lifeInfo = role_life_info()    lifeInfo.role_id = ModelPlayer.getId()    lifeInfo.cur_life = 0    table.insert(lifelist, lifeInfo)end function RoleMgr.settleLifeInfo()    --玩家死否存活    local function MyfreindIsAlive(role_id)        local pRet = false        local curLife = 0         local tb =  RoleMgr.getConfig("rmc_player_table")          for key,_roleInfo in pairs(tb) do            local serverRoleId = _roleInfo:getConfig("serve_role_id")            if role_id == serverRoleId then                 pRet = true                 local attr = _roleInfo:getDataInfo("attr")                curLife = attr:getByName("life")            end         end         return pRet,curLife    end     --玩家是否被杀死    local function isBeKill(role_id)        local friendBeKilllist = RoleMgr.getConfig("friend_beKilllist")         for key,server_role_id in pairs(friendBeKilllist) do            if role_id == server_role_id then                 return true            end         end        return false    end     local lifelist =  RoleMgr.getConfig("jjc_friend_lifeInfo")     for key,lifeInfo in pairs(lifelist) do         local _ret,_curlife = MyfreindIsAlive(lifeInfo.role_id)        if _ret == true then            lifeInfo.cur_life = _curlife        elseif isBeKill(lifeInfo.role_id) == true then            lifeInfo.cur_life = 0        end     end     return lifelistend --是否双方队长都死翘了function RoleMgr.isDoubleLeaderBeKill()    local pRet = false    local enemyLeaderbeKill = RoleMgr.getConfig("is_enemy_bekill")     local pleyerBeKill = FightDateCache.getData("fd_player_knockout")     if enemyLeaderbeKill == true and pleyerBeKill == true then         pRet = true     end     return pRetend 