﻿------------------------------------------------------------------------ 作者：lewis-- 日期：2013-04-11-- 描述：格子类厂----------------------------------------------------------------------GridFactory = {}function GridFactory.create(tag)	local grid = nil	if tag == "door" then		grid = GridDoor.new(tag)	elseif tag == "barrier" then		grid = GridBarrier.new(tag)	elseif tag == "enemy" then		grid = GridEnemy.new(tag)	elseif tag == "item" then		grid = GridItem.new(tag)	elseif tag == "monster" then		grid = GridMonster.new(tag)	elseif tag == "empty" then		grid = GridEmpty.new(tag)    elseif tag == "boss_body" then        grid = GridBossBody.new(tag)    elseif tag == "boss" then        grid = GridBoss.new(tag)    elseif tag == "summon" then         grid = GridSummon.new(tag)	end	if grid == nil then		gridPrint("can't create grid", tag)	else		gridPrint("create grid with tag", tag)	end	return gridend