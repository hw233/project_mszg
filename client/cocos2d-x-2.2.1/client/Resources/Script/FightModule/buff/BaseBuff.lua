--region BaseBuff.lua
--Author : Administrator
--Date   : 2014/11/27

BaseBuff=class()

constBuff = {
    ["MLSY"] = 
    {
     acceptskilllist = {15,16,18},
     changeId = {34,34,36}
    },
     ["MLSY2"] = 
    {
     acceptskilllist = {15,16}
    }
}

local mInstanceId = 0

function BaseBuff:ctor()
    self.mConfigTB	= {}
    self.mConfigTB["instance_id"] = mInstanceId
    mInstanceId = mInstanceId + 1
end

function BaseBuff:init(id,quality,level,caster,talentlv)
    local BuffInfo = SkillConfig.getSkillBuffInfo(id,quality,level,talentlv)
    local instance_id = nil 
    

    self.mConfigTB["fold_times"]  =   1
    self.mConfigTB["fold_maxtimes"]  =  BuffInfo.fold_maxtimes--BuffInfo.fold_maxtimes

    self.mConfigTB["buff_id"]  =   BuffInfo.buff_id
    self.mConfigTB["buff_type"]  = BuffInfo.buff_type   --1 buff 2 deBuff 3光环 4 祝福
    self.mConfigTB["shader_name"]   =   BuffInfo.shader_name
    self.mConfigTB["buff_replace_type"]  =   BuffInfo.buff_replace_type
    self.mConfigTB["is_invalid"] = false  --是否即将无效  无效就移除
    self.mConfigTB["buff_icon"] = BuffInfo.buff_icon
    self.mConfigTB["new_flag"] = false --是否是新BUFF 用来播放动画
    self.mConfigTB["buff_name"] = BuffInfo.buff_name
    self.mConfigTB["buff_made"] = BuffInfo.buff_made or 1
    self.mConfigTB["talentlv"] = talentlv or 1
    self.mConfigTB["modifyTB"]  =   self:parseModifyAttr(BuffInfo,quality,level)


    self.mCaster = caster
    if caster~= nil then 
        instance_id = caster:getConfig("refences_id")
    end

    self.mConfigTB["caster_instance_id"] = instance_id      --上BUFF的role实例ID 第三方(陷阱)为nil
    self.mConfigTB["target"] = BuffInfo.target 
end
--buff
--signal_times 单次叠加层数
function BaseBuff:fold(_role,newbuff,signal_times)
    local duration = newbuff:getBuffConfig("duration")
    local fold_times = self.mConfigTB["fold_times"] 
    local fold_maxtimes = self.mConfigTB["fold_maxtimes"] 

    local TempFoldTime = fold_times

    local fold_times = fold_times + signal_times
    if fold_times <= fold_maxtimes then 
        self:setBuffConfig("fold_times",fold_times)   
        self:setBuffConfig("duration",duration) --时间覆盖  

        for key=1 ,signal_times do 
            self:startImpact(_role)
        end
    else 
        self:setBuffConfig("fold_times",fold_maxtimes) --时间覆盖
        self:setBuffConfig("duration",duration)

        if fold_maxtimes-TempFoldTime > 0 then 
            for key=1 ,fold_maxtimes-TempFoldTime do 
                self:startImpact(_role)
            end
        end
    end 

    

end 

function BaseBuff:parseModifyAttr(BuffInfo,quality,level)
    local modifyTable = {}
    local nameStr = BuffInfo.modify_attribute

    SkillMgr.parseStatusString(modifyTable, nameStr, valueStr, quality, level,self:getBuffConfig("buff_made"),self:getBuffConfig("talentlv"))
    return modifyTable
end 


--获得数据

function BaseBuff:onStep()
    local buffDuration = self:getBuffConfig("duration")
    if buffDuration > 1 then 
        buffDuration =  buffDuration - 1
    else 
        self:setBuffConfig("is_invalid",true)
    end 
    self:setBuffConfig("duration",buffDuration)
end


--对单个buff 对生命的修改的值
function BaseBuff:modifyLifeValue(_role)
end 


--buff开启 修改属性

--buff结算 还原属性
function BaseBuff:stopImpact(_role)
    end 
end 


--改变基础数据,不改变生命值

--endregion