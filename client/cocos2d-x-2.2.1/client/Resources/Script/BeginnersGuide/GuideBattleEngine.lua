﻿----------------------------------------------------------------------
	GuideView.reset()
	local paramTB = GuideMgr.parseParamer(config.param)
	local width = paramTB["width"]
	local height = paramTB["height"]
	local x = paramTB["x"]
	local y = paramTB["y"]
	if width and height and x and y then
		GuideView.updateSize(width, height, false)
		GuideView.updatePos(ccp(x, y), config.direct)
	else
		GuideView.updatePos(ccp(360, config.posy or 420), config.direct)
	end
	GuideView.updateLock(config.lock)
	GuideView.updateText(getTextId())
	mEffectiveMsgTB = {"on_touch"}

    local  function getccpByPosId(posid)
        posid = tonumber(posid) local h = 400
        local pos = nil
        if posid == 1 then
            pos = ccp(260, h)
        elseif posid == 2 then
            pos = ccp(180, h)
        elseif posid == 3 then
           pos = ccp(100, h)
        elseif posid == 4 then
            pos = ccp(380, h)
        elseif posid == 5 then
            pos = ccp(460, h)
        elseif posid == 6 then
            pos = ccp(540, h)
        end
		
        return pos
    end 

    local speaker_iconTB = CommonFunc_split(singleDialogInfo.speaker_icon, ",")
    local speaker_posTB = CommonFunc_split(singleDialogInfo.speaker_pos, ",")
    local scaleTB = CommonFunc_split(singleDialogInfo.scale, ",")
    local isflipTB = CommonFunc_split(singleDialogInfo.isflip, ",")


    for k,icon_id in pairs(speaker_iconTB) do 

        local plistFile = ""
        if tonumber(icon_id) ~= 0 then 
            plistFile = ResourceManger.getAnimationFrameById(icon_id).name	
        else 
             local role_tplt = ModelPlayer.getRoleUpAppence(ModelPlayer.getRoleType(),ModelPlayer.getAdvancedLevel()	)	
	         plistFile = ResourceManger.getAnimationFrameById(role_tplt.icon).name
        end 

        ResourceManger.LoadSinglePicture(plistFile)	
        local strsb = plistFile.."_wait_001.png"
        local icon = CCSprite:createWithSpriteFrameName(strsb);

        icon:setAnchorPoint(ccp(0.5, 0.0))

	    icon:setPosition(getccpByPosId(speaker_posTB[k]))

        if isflipTB[k] == "1" then 
            icon:setFlipX(true)
        end 
       
        icon:setScale(tonumber(scaleTB[k]))

        return icon
        --BattleDialog.mRootView:addChild(icon,k)
    end 
end 

local function BattleDialogCreateSpeakContent(singleDialogInfo)

    local layerColor = CCLayerColor:create(ccc4(0,0,0,128),640,960)
    GuideView.getIntance():addChild(layerColor,-1)

    local mDialogBg = CCSprite:create("talkbackgroud.png")
	GuideView.getIntance():addChild(mDialogBg,10)
	mDialogBg:setAnchorPoint(ccp(0.5, 0.0))
	mDialogBg:setPosition(ccp(320, 300))

    --对话文字
     local speakerName = ""
     if singleDialogInfo.speaker == '0' then 
        speakerName = ModelPlayer.getNickName()
     else 
        speakerName = singleDialogInfo.speaker
     end 

     local Title = CCLabelTTF:create(speakerName, "Aril", 24);
     Title:setPosition(ccp(110,145))
	 Title:setColor(ccc3(123,83,55))
     Title:setAnchorPoint(ccp(0.5, 0.5))
     mDialogBg:addChild(Title)

    --对话内容
    local layer,line = RichText.create(singleDialogInfo.content, CCSizeMake(495, 180), 22, {},"copydialog.fnt")
    local size = mDialogBg:boundingBox().size

    layer:setPosition(ccp(60,400))

    GuideView.getIntance():addChild(layer,10)
end 
    BattleDialogCreateSpeakContent(singleDialogInfo)