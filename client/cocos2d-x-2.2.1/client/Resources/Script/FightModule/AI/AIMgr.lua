﻿----------------------------------------------------------------------
function AIMgr.isOnControll()

    if FightDateCache.getData("fd_global_lockevent") then 
        return false
    end 

    if  FightDateCache.getData("fd_game_mode") ~= 5 then 
	    if FightDateCache.getData("fd_player_knockout") then
		    return false
	    end
    end
	if FightDateCache.getData("fd_enemy_knockout") then
		return false
	end
	if NetSendLoadLayer.isWaitMessage() == true then
		return false
	end
	if UIManager.getLayerCount() > 1 and  UIManager.isAllUIEnabled() == false then 
		return false
	end
	return true
end