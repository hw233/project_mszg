﻿------------------------------------------------------------------------ 作者：lewis-- 日期：2013-3-31-- 描述：角色视图基类---------------------------------------------------------------------ActionSprite = class()--释放retain的结点local function releaseRetainNode(node)	if node ~= nil then		node:release()	endend--构造函数function ActionSprite:ctor(dir)	self.mMoveNode 		= nil		--移动结点	self.mScaleNode		= nil		--执行放大缩小动作的结点	self.mSprite 		= nil		--精灵	self.mAmiedSPrite	= nil		--被锁定精灵	self.mIcon 			= 0			--动画id	self.mRestoreIcon	= 0			--存储id	self.mOriginalPos	= ccp(0, 0)	--初始位置	self.mPos			= ccp(0, 0)	--现在位置	self.mDirection		= dir		--默认向右,-1向右		self.mIdleAni		= nil		--待机动画action	self.mAttackAni		= nil		--攻击动画	self.mHitAni		= nil		--受击动画		self.attack_frame 	= 0	self.hit_frame		= 0	self.mFilename		= ""		self.mSoundEnter 	= 0	self.mSoundHurt 	= 0	self.mSoundDie 		= 0		self.mDeadAniStr	= ""	self.mDeadAniFrames	= 0		self.isSelected = falseend--初始化function ActionSprite:init(layer, pos, icon, zOrder)	--初始化基本数据	self.mPos 				= pos	self.mOriginalPos 		= ccp(pos.x, pos.y)	self.mIcon 				= icon	self.mRestoreIcon  		= icon		self:loadAnimate()	self:createView(layer, zOrder)	SoundDispath.monsterEnter(self.mSoundEnter)	self:onIdle()end--清理function ActionSprite:cleanup()	self:releaseAnimate()	self.mMoveNode:removeFromParentAndCleanup(true)end--加载常用动画function ActionSprite:loadAnimate()	local config = ResourceManger.getAnimationFrameById(self.mIcon)		--加载资源	local plistName = config.name..".plist"	CCSpriteFrameCache:sharedSpriteFrameCache():addSpriteFramesWithFile(plistName)		--第一张图名	self.mFilename = config.name.."_"..config.wait.."_001.png"		--待机动画	local str = string.format("%s_%s", config.name, config.wait).."_%03d.png"	self.mIdleAni = CCRepeatForever:create(CCAnimate:create(FightAnimationMgr.roleAnimate(str, config.wait_frame)))	self.mIdleAni:retain()		--攻击动画	str = string.format("%s_%s", config.name, config.attack).."_%03d.png"	self.mAttackAni = CCAnimate:create(FightAnimationMgr.roleAnimate(str, config.attack_frame))	self.mAttackAni:retain()		--受击动画	str = string.format("%s_%s", config.name, config.hited).."_%03d.png"	self.mHitAni = CCAnimate:create(FightAnimationMgr.roleAnimate(str, config.hited_frame))	self.mHitAni:retain()		--死亡动画	self.mDeadAniStr = string.format("%s_%s", config.name, config.dead).."_%03d.png"	self.mDeadAniFrames = config.dead_frame		--声音配置	self.mSoundEnter 	= config.sound_enter	self.mSoundHurt 	= config.sound_hurt	self.mSoundDie 		= config.sound_dieend--释放结点function ActionSprite:releaseAnimate()	releaseRetainNode(self.mIdleAni)	releaseRetainNode(self.mAttackAni)	releaseRetainNode(self.mHitAni)	self.mIdleAni		= nil		--待机动画action	self.mAttackAni		= nil		--攻击动画	self.mHitAni		= nil		--受击动画endfunction ActionSprite:setRoleVisible(visible)    self.mMoveNode:setVisible(visible)end --创建视图function ActionSprite:createView(layer, zOrder)	--创建移动结点	local node = CCLayer:create()	layer:addChild(node, zOrder, 0)	node:setAnchorPoint(ccp(0, 0))	--放大位置不偏移	node:setPosition(self.mPos)		self.mMoveNode = node		--创建缩放结点	local node = CCLayer:create()	self.mMoveNode:addChild(node, zOrder, 0)	node:setAnchorPoint(ccp(0, 0))	--放大位置不偏移	node:setPosition(ccp(0, 0))		self.mScaleNode = node		--创建精灵	local sprite = CCSprite:createWithSpriteFrameName(self.mFilename)	self.mScaleNode:addChild(sprite)	local size = sprite:getContentSize()	local y = 250 - 190	sprite:setPosition(ccp(0, y))	sprite:setAnchorPoint(ccp(140 / 288,  y / 250))		self.mSprite = spriteend--待机状态function ActionSprite:onIdle()    self.mSprite:setColor(ccc3(255,255,255))    --self.mSprite:setOpacity(255)	local sprite = self.mSprite	if sprite == nil then		return	end	sprite:stopAllActions()	sprite:runAction(self.mIdleAni)end--攻击状态function ActionSprite:onAttack(callback)	local sprite = self.mSprite	if sprite == nil then		return	end	sprite:stopAllActions()		--被击动画播完回调	local function attackAniDone(sender)		self:onIdle()        if callback then callback() end	end	sprite:runAction(CCSequence:createWithTwoActions(self.mAttackAni, CCCallFuncN:create(attackAniDone)))end--施法状态function ActionSprite:onMagic()	local sprite = self.mSprite	if sprite == nil then		return	end	sprite:stopAllActions()		--被击动画播完回调	local function attackAniDone(sender)		self:onIdle()	end	sprite:runAction(CCSequence:createWithTwoActions(self.mAttackAni, CCCallFuncN:create(attackAniDone)))end--受机状态function ActionSprite:onHit()	local sprite = self.mSprite	if sprite == nil then		return	end	sprite:stopAllActions()		--被击动画播完回调	local function hitAniDone(sender)		self:onIdle()	end	SoundDispath.roleHurt(self.mSoundHurt)	sprite:runAction(CCSequence:createWithTwoActions(self.mHitAni, CCCallFuncN:create(hitAniDone)))end--妖术，改变造型function ActionSprite:onHex(newicon)	if self.mSprite == nil then		return	end	if newicon == 0 then		--恢复原来的造型		if self.mIcon ~= self.mRestoreIcon then			self.mIcon = self.mRestoreIcon			self:releaseAnimate()			self:loadAnimate()			self:onIdle()		end	elseif newicon ~= self.mIcon then	--新的造型		self:releaseAnimate()		self.mIcon = newicon		self:loadAnimate()		self:onIdle()	endend--改变朝向function ActionSprite:onDirection(dir)	if self.mSprite == nil then		return	end	self.mSprite:setFlipX(self.mDirection ~= dir)end--自爆怪死亡动画  返回：totalTime 动画延时function ActionSprite:selfDetonateOnKnockout()    --一共用时      local totalTime = 0.05 * 10 
    
    local moveLeft  = CCMoveBy:create(0.05, ccp(15,0))
	local moveRight = CCMoveBy:create(0.05, ccp(-15,0))
	local action = CCRepeat:create(CCSequence:createWithTwoActions(moveLeft, moveRight), 10)
    self.mMoveNode:runAction(action)    --放大节点            local arr2 = CCArray:create()    arr2:addObject(CCScaleBy:create(1.0,1.5))    arr2:addObject(CCCallFuncN:create(function(sender)    local effect = EffectAnimate.new()	effect:init(ccp(self.mPos.x,self.mPos.y + 94), 89)        effect:play():setScale(1.5)              self:cleanup()    end))   self.mScaleNode:runAction(CCSequence:create(arr2))   return totalTimeend--自爆function ActionSprite:onBaneling()    local moveLeft  = CCMoveBy:create(0.05, ccp(15,0))	local moveRight = CCMoveBy:create(0.05, ccp(-15,0))	local action = CCRepeat:create(CCSequence:createWithTwoActions(moveLeft, moveRight), 10)    self.mMoveNode:runAction(action)    --放大节点		local function banelingCB(sender)		local effect = EffectAnimate.new()		effect:init(ccp(self.mPos.x,self.mPos.y + 94), 89)        effect:play():setScale(1.5)	end            local arr2 = CCArray:create()    arr2:addObject(CCScaleBy:create(1.0,1.5))    arr2:addObject(CCCallFuncN:create(banelingCB))    self.mScaleNode:runAction(CCSequence:create(arr2))end--逃跳function ActionSprite:escape()	if self.mDeadAniFrames == 0 then		self:cleanup() 		return	end	local sprite = self.mSprite	if sprite == nil then		return	end	sprite:stopAllActions()		--被击动画播完回调	local function escapeDone(sender)		self:cleanup() 	end	local animate = CCAnimate:create(FightAnimationMgr.roleAnimate(self.mDeadAniStr, self.mDeadAniFrames))	sprite:runAction(CCSequence:createWithTwoActions(animate, CCCallFuncN:create(escapeDone)))end--被K.Ofunction ActionSprite:onKnockout(tag)	SoundDispath.roleDie(self.mSoundDie)	if tag == "normal" then                self:cleanup()     elseif tag == "baneling" then		self:selfDetonateOnKnockout()	elseif tag == "escape" then		self:escape()	else		self:cleanup()     endend--function ActionSprite:onShader(name)	local sprite = self.mSprite	if sprite == nil then		return	end	local bShader = true	if name == nil then bShader = false end	name = name or "buff_purple.fsh"	Lewis:spriteShaderEffect(sprite, name, bShader)end--躲闪function ActionSprite:onDodge()	local node = self.mMoveNode	node:stopAllActions()	node:setPosition(self.mPos)		local moveby = CCMoveBy:create(0.15, CCPointMake(-50 * self.mDirection, 0))	local arr = CCArray:create()    arr:addObject(moveby)	arr:addObject(moveby:reverse())	node:runAction(CCSequence:create(arr))end--被锁定function ActionSprite:onAimed(bOn)	if self.mAmiedSPrite == nil then		local sprite = CCSprite:create("target_select.png")		self.mScaleNode:addChild(sprite, 100)		sprite:setPosition(ccp(0, 50))		local act1 = CCEaseBackInOut:create(CCScaleBy:create(0.5, 1.4))		local act2 = CCEaseBackInOut:create(CCScaleBy:create(0.2, 1 / 1.4))		sprite:runAction(CCRepeatForever:create(CCSequence:createWithTwoActions(act1, act2)))		self.mAmiedSPrite = sprite	end	self.mAmiedSPrite:setVisible(bOn)end--精灵黑色渐出function ActionSprite:onTintToBright(duration)    self.mSprite:setColor(ccc3(0,0,0))    self.mSprite:runAction( CCTintTo:create(duration, 255, 255, 255) )    -- CCTintTo* create(float duration, GLubyte red, GLubyte green, GLubyte blue);end--精灵淡入function ActionSprite:onFadeIn(duration)    self.mSprite:setOpacity(0)    self.mSprite:runAction( CCFadeIn:create(duration) )    -- CCTintTo* create(float duration, GLubyte red, GLubyte green, GLubyte blue);end--潜行是否function ActionSprite:onStealth(bOn)	local sprite = self.mSprite	if sprite == nil then		return	end	if bOn then		sprite:setOpacity(128)	else		sprite:setOpacity(255)	endend