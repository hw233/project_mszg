
function req_check_version ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_check_version"]
    end
    tb.version = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.version)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.version = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_check_version"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_check_version_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_check_version_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_check_version_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_login ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_login"]
    end
    tb.account = ""
    tb.password = ""

    tb.encode = function(byteArray)
    	byteArray.write_string(tb.account)
    	byteArray.write_string(tb.password)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.account = byteArray.read_string();
        tb.password = byteArray.read_string();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_login"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_login_check ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_login_check"]
    end
    tb.uid = ""
    tb.token = ""

    tb.encode = function(byteArray)
    	byteArray.write_string(tb.uid)
    	byteArray.write_string(tb.token)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.uid = byteArray.read_string();
        tb.token = byteArray.read_string();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_login_check"])
        return tb.encode(byteArray)
    end

    return tb

end

function role_data ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_role_data"]
    end
    tb.role_id = 0
    tb.role_status = 0
    tb.type = 0
    tb.lev = 0
    tb.name = ""
    tb.is_del = 0
    tb.time_left = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.role_id)
    	byteArray.write_int(tb.role_status)
    	byteArray.write_int(tb.type)
    	byteArray.write_int(tb.lev)
    	byteArray.write_string(tb.name)
    	byteArray.write_int(tb.is_del)
    	byteArray.write_int(tb.time_left)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.role_id = byteArray.read_uint64();
        tb.role_status = byteArray.read_int();
        tb.type = byteArray.read_int();
        tb.lev = byteArray.read_int();
        tb.name = byteArray.read_string();
        tb.is_del = byteArray.read_int();
        tb.time_left = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_role_data"])
        return tb.encode(byteArray)
    end

    return tb

end

function notifu_login_check_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notifu_login_check_result"]
    end
    tb.result = 0
    tb.error_code = 0
    tb.emoney = 0
    tb.role_infos = {}

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
    	byteArray.write_int(tb.error_code)
    	byteArray.write_int(tb.emoney)
        byteArray.write_uint16(#(tb.role_infos))
        for k, v in pairs(tb.role_infos) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.error_code = byteArray.read_int();
        tb.emoney = byteArray.read_int();
        local countOfrole_infos = byteArray.read_uint16()
        tb.role_infos = {}
        for i = 1, countOfrole_infos do
            local temp = role_data()
            temp.decode(byteArray)
            table.insert(tb.role_infos, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notifu_login_check_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_login_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_login_result"]
    end
    tb.id = 0
    tb.result = 0
    tb.emoney = 0
    tb.role_infos = {}

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.id)
    	byteArray.write_int(tb.result)
    	byteArray.write_int(tb.emoney)
        byteArray.write_uint16(#(tb.role_infos))
        for k, v in pairs(tb.role_infos) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.id = byteArray.read_uint64();
        tb.result = byteArray.read_int();
        tb.emoney = byteArray.read_int();
        local countOfrole_infos = byteArray.read_uint16()
        tb.role_infos = {}
        for i = 1, countOfrole_infos do
            local temp = role_data()
            temp.decode(byteArray)
            table.insert(tb.role_infos, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_login_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_sys_msg ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_sys_msg"]
    end
    tb.code = 0
    tb.Params = {}

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.code)
        byteArray.write_uint16(#(tb.Params))
        for k, v in pairs (tb.Params) do
            byteArray.write_string(v)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.code = byteArray.read_int();
        local countOfParams = byteArray.read_uint16()
        tb.Params = {}
        for i = 1, countOfParams do
             table.insert(tb.Params, byteArray.read_string())
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_sys_msg"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_select_role ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_select_role"]
    end
    tb.role_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.role_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.role_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_select_role"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_select_role_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_select_role_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_select_role_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_delete_role ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_delete_role"]
    end
    tb.role_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.role_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.role_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_delete_role"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_delete_role_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_delete_role_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_delete_role_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_recover_del_role ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_recover_del_role"]
    end
    tb.role_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.role_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.role_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_recover_del_role"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_recover_del_role_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_recover_del_role_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_recover_del_role_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_reselect_role ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_reselect_role"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_reselect_role"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_roles_infos ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_roles_infos"]
    end
    tb.emoney = 0
    tb.role_infos = {}

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.emoney)
        byteArray.write_uint16(#(tb.role_infos))
        for k, v in pairs(tb.role_infos) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.emoney = byteArray.read_int();
        local countOfrole_infos = byteArray.read_uint16()
        tb.role_infos = {}
        for i = 1, countOfrole_infos do
            local temp = role_data()
            temp.decode(byteArray)
            table.insert(tb.role_infos, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_roles_infos"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_gm_optition ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_gm_optition"]
    end
    tb.opt_type = 0
    tb.value = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.opt_type)
    	byteArray.write_int(tb.value)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.opt_type = byteArray.read_int();
        tb.value = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_gm_optition"])
        return tb.encode(byteArray)
    end

    return tb

end

function player_data ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_player_data"]
    end
    tb.account = ""
    tb.username = ""
    tb.sex = 0

    tb.encode = function(byteArray)
    	byteArray.write_string(tb.account)
    	byteArray.write_string(tb.username)
    	byteArray.write_int(tb.sex)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.account = byteArray.read_string();
        tb.username = byteArray.read_string();
        tb.sex = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_player_data"])
        return tb.encode(byteArray)
    end

    return tb

end

function sculpture_data ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_sculpture_data"]
    end
    tb.temp_id = 0
    tb.level = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.temp_id)
    	byteArray.write_int(tb.level)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.temp_id = byteArray.read_int();
        tb.level = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_sculpture_data"])
        return tb.encode(byteArray)
    end

    return tb

end

function stime ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_stime"]
    end
    tb.year = 0
    tb.month = 0
    tb.day = 0
    tb.hour = 0
    tb.minute = 0
    tb.second = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.year)
    	byteArray.write_int(tb.month)
    	byteArray.write_int(tb.day)
    	byteArray.write_int(tb.hour)
    	byteArray.write_int(tb.minute)
    	byteArray.write_int(tb.second)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.year = byteArray.read_int();
        tb.month = byteArray.read_int();
        tb.day = byteArray.read_int();
        tb.hour = byteArray.read_int();
        tb.minute = byteArray.read_int();
        tb.second = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_stime"])
        return tb.encode(byteArray)
    end

    return tb

end

function mons_item ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_mons_item"]
    end
    tb.id = 0
    tb.amount = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.id)
    	byteArray.write_int(tb.amount)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.id = byteArray.read_int();
        tb.amount = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_mons_item"])
        return tb.encode(byteArray)
    end

    return tb

end

function reward_item ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_reward_item"]
    end
    tb.id = 0
    tb.amount = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.id)
    	byteArray.write_int(tb.amount)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.id = byteArray.read_int();
        tb.amount = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_reward_item"])
        return tb.encode(byteArray)
    end

    return tb

end

function smonster ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_smonster"]
    end
    tb.pos = 0
    tb.monsterid = 0
    tb.dropout = {}

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.pos)
    	byteArray.write_int(tb.monsterid)
        byteArray.write_uint16(#(tb.dropout))
        for k, v in pairs(tb.dropout) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.pos = byteArray.read_int();
        tb.monsterid = byteArray.read_int();
        local countOfdropout = byteArray.read_uint16()
        tb.dropout = {}
        for i = 1, countOfdropout do
            local temp = mons_item()
            temp.decode(byteArray)
            table.insert(tb.dropout, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_smonster"])
        return tb.encode(byteArray)
    end

    return tb

end

function strap ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_strap"]
    end
    tb.pos = 0
    tb.trapid = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.pos)
    	byteArray.write_int(tb.trapid)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.pos = byteArray.read_int();
        tb.trapid = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_strap"])
        return tb.encode(byteArray)
    end

    return tb

end

function saward ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_saward"]
    end
    tb.pos = 0
    tb.awardid = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.pos)
    	byteArray.write_int(tb.awardid)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.pos = byteArray.read_int();
        tb.awardid = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_saward"])
        return tb.encode(byteArray)
    end

    return tb

end

function sfriend ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_sfriend"]
    end
    tb.pos = 0
    tb.friend_role_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.pos)
    	byteArray.write_int(tb.friend_role_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.pos = byteArray.read_int();
        tb.friend_role_id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_sfriend"])
        return tb.encode(byteArray)
    end

    return tb

end

function battle_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_battle_info"]
    end
    tb.sculpture = {}
    tb.life = 0
    tb.speed = 0
    tb.atk = 0
    tb.hit_ratio = 0
    tb.miss_ratio = 0
    tb.critical_ratio = 0
    tb.tenacity = 0
    tb.power = 0

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.sculpture))
        for k, v in pairs(tb.sculpture) do
            byteArray = v.encode(byteArray)
        end
    	byteArray.write_int(tb.life)
    	byteArray.write_int(tb.speed)
    	byteArray.write_int(tb.atk)
    	byteArray.write_int(tb.hit_ratio)
    	byteArray.write_int(tb.miss_ratio)
    	byteArray.write_int(tb.critical_ratio)
    	byteArray.write_int(tb.tenacity)
    	byteArray.write_int(tb.power)
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOfsculpture = byteArray.read_uint16()
        tb.sculpture = {}
        for i = 1, countOfsculpture do
            local temp = sculpture_data()
            temp.decode(byteArray)
            table.insert(tb.sculpture, temp)
        end
        tb.life = byteArray.read_int();
        tb.speed = byteArray.read_int();
        tb.atk = byteArray.read_int();
        tb.hit_ratio = byteArray.read_int();
        tb.miss_ratio = byteArray.read_int();
        tb.critical_ratio = byteArray.read_int();
        tb.tenacity = byteArray.read_int();
        tb.power = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_battle_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function talent ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_talent"]
    end
    tb.talent_id = 0
    tb.level = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.talent_id)
    	byteArray.write_int(tb.level)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.talent_id = byteArray.read_int();
        tb.level = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_talent"])
        return tb.encode(byteArray)
    end

    return tb

end

function senemy ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_senemy"]
    end
    tb.role_id = 0
    tb.name = ""
    tb.pos = 0
    tb.level = 0
    tb.type = 0
    tb.potence_level = 0
    tb.advanced_level = 0
    tb.battle_prop = {}
    tb.talent_list = {}
    tb.team_tag = 0
    tb.id_leader = 0
    tb.cur_life = 0
    tb.mitigation = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.role_id)
    	byteArray.write_string(tb.name)
    	byteArray.write_int(tb.pos)
    	byteArray.write_int(tb.level)
    	byteArray.write_int(tb.type)
    	byteArray.write_int(tb.potence_level)
    	byteArray.write_int(tb.advanced_level)
        tb.battle_prop.encode(byteArray);
        byteArray.write_uint16(#(tb.talent_list))
        for k, v in pairs(tb.talent_list) do
            byteArray = v.encode(byteArray)
        end
    	byteArray.write_int(tb.team_tag)
    	byteArray.write_int(tb.id_leader)
    	byteArray.write_int(tb.cur_life)
    	byteArray.write_int(tb.mitigation)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.role_id = byteArray.read_uint64();
        tb.name = byteArray.read_string();
        tb.pos = byteArray.read_int();
        tb.level = byteArray.read_int();
        tb.type = byteArray.read_int();
        tb.potence_level = byteArray.read_int();
        tb.advanced_level = byteArray.read_int();
        tb.battle_prop = battle_info();
        tb.battle_prop.decode(byteArray);
        local countOftalent_list = byteArray.read_uint16()
        tb.talent_list = {}
        for i = 1, countOftalent_list do
            local temp = talent()
            temp.decode(byteArray)
            table.insert(tb.talent_list, temp)
        end
        tb.team_tag = byteArray.read_int();
        tb.id_leader = byteArray.read_int();
        tb.cur_life = byteArray.read_int();
        tb.mitigation = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_senemy"])
        return tb.encode(byteArray)
    end

    return tb

end

function game_map ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_game_map"]
    end
    tb.monster = {}
    tb.key = 0
    tb.start = 0
    tb.award = {}
    tb.trap = {}
    tb.barrier = {}
    tb.friend = {}
    tb.scene = 0
    tb.enemy = {}
    tb.boss = {}
    tb.boss_rule = 0

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.monster))
        for k, v in pairs(tb.monster) do
            byteArray = v.encode(byteArray)
        end
    	byteArray.write_int(tb.key)
    	byteArray.write_int(tb.start)
        byteArray.write_uint16(#(tb.award))
        for k, v in pairs(tb.award) do
            byteArray = v.encode(byteArray)
        end
        byteArray.write_uint16(#(tb.trap))
        for k, v in pairs(tb.trap) do
            byteArray = v.encode(byteArray)
        end
        byteArray.write_uint16(#(tb.barrier))
        for k, v in pairs (tb.barrier) do
            byteArray.write_int(v)
        end
        byteArray.write_uint16(#(tb.friend))
        for k, v in pairs(tb.friend) do
            byteArray = v.encode(byteArray)
        end
    	byteArray.write_int(tb.scene)
        byteArray.write_uint16(#(tb.enemy))
        for k, v in pairs(tb.enemy) do
            byteArray = v.encode(byteArray)
        end
        byteArray.write_uint16(#(tb.boss))
        for k, v in pairs(tb.boss) do
            byteArray = v.encode(byteArray)
        end
    	byteArray.write_int(tb.boss_rule)
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOfmonster = byteArray.read_uint16()
        tb.monster = {}
        for i = 1, countOfmonster do
            local temp = smonster()
            temp.decode(byteArray)
            table.insert(tb.monster, temp)
        end
        tb.key = byteArray.read_int();
        tb.start = byteArray.read_int();
        local countOfaward = byteArray.read_uint16()
        tb.award = {}
        for i = 1, countOfaward do
            local temp = saward()
            temp.decode(byteArray)
            table.insert(tb.award, temp)
        end
        local countOftrap = byteArray.read_uint16()
        tb.trap = {}
        for i = 1, countOftrap do
            local temp = strap()
            temp.decode(byteArray)
            table.insert(tb.trap, temp)
        end
        local countOfbarrier = byteArray.read_uint16()
        tb.barrier = {}
        for i = 1, countOfbarrier do
             table.insert(tb.barrier, byteArray.read_int())
        end
        local countOffriend = byteArray.read_uint16()
        tb.friend = {}
        for i = 1, countOffriend do
            local temp = sfriend()
            temp.decode(byteArray)
            table.insert(tb.friend, temp)
        end
        tb.scene = byteArray.read_int();
        local countOfenemy = byteArray.read_uint16()
        tb.enemy = {}
        for i = 1, countOfenemy do
            local temp = senemy()
            temp.decode(byteArray)
            table.insert(tb.enemy, temp)
        end
        local countOfboss = byteArray.read_uint16()
        tb.boss = {}
        for i = 1, countOfboss do
            local temp = smonster()
            temp.decode(byteArray)
            table.insert(tb.boss, temp)
        end
        tb.boss_rule = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_game_map"])
        return tb.encode(byteArray)
    end

    return tb

end

function item ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_item"]
    end
    tb.inst_id = 0
    tb.temp_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.inst_id)
    	byteArray.write_int(tb.temp_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.inst_id = byteArray.read_uint64();
        tb.temp_id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_item"])
        return tb.encode(byteArray)
    end

    return tb

end

function pack_item ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_pack_item"]
    end
    tb.id = 0
    tb.itemid = 0
    tb.itemtype = 0
    tb.amount = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.id)
    	byteArray.write_int(tb.itemid)
    	byteArray.write_int(tb.itemtype)
    	byteArray.write_int(tb.amount)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.id = byteArray.read_uint64();
        tb.itemid = byteArray.read_int();
        tb.itemtype = byteArray.read_int();
        tb.amount = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_pack_item"])
        return tb.encode(byteArray)
    end

    return tb

end

function copy_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_copy_info"]
    end
    tb.copy_id = 0
    tb.max_score = 0
    tb.pass_times = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.copy_id)
    	byteArray.write_int(tb.max_score)
    	byteArray.write_int(tb.pass_times)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.copy_id = byteArray.read_int();
        tb.max_score = byteArray.read_int();
        tb.pass_times = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_copy_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function equipmentinfo ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_equipmentinfo"]
    end
    tb.equipment_id = 0
    tb.temp_id = 0
    tb.strengthen_level = 0
    tb.gems = {}
    tb.attr_ids = {}
    tb.gem_extra = 0
    tb.bindtype = 0
    tb.bindstatus = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.equipment_id)
    	byteArray.write_int(tb.temp_id)
    	byteArray.write_int(tb.strengthen_level)
        byteArray.write_uint16(#(tb.gems))
        for k, v in pairs (tb.gems) do
            byteArray.write_int(v)
        end
        byteArray.write_uint16(#(tb.attr_ids))
        for k, v in pairs (tb.attr_ids) do
            byteArray.write_int(v)
        end
    	byteArray.write_int(tb.gem_extra)
    	byteArray.write_int(tb.bindtype)
    	byteArray.write_int(tb.bindstatus)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.equipment_id = byteArray.read_uint64();
        tb.temp_id = byteArray.read_int();
        tb.strengthen_level = byteArray.read_int();
        local countOfgems = byteArray.read_uint16()
        tb.gems = {}
        for i = 1, countOfgems do
             table.insert(tb.gems, byteArray.read_int())
        end
        local countOfattr_ids = byteArray.read_uint16()
        tb.attr_ids = {}
        for i = 1, countOfattr_ids do
             table.insert(tb.attr_ids, byteArray.read_int())
        end
        tb.gem_extra = byteArray.read_int();
        tb.bindtype = byteArray.read_int();
        tb.bindstatus = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_equipmentinfo"])
        return tb.encode(byteArray)
    end

    return tb

end

function extra_item ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_extra_item"]
    end
    tb.item_id = 0
    tb.count = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.item_id)
    	byteArray.write_int(tb.count)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.item_id = byteArray.read_int();
        tb.count = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_extra_item"])
        return tb.encode(byteArray)
    end

    return tb

end

function friend_data ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_friend_data"]
    end
    tb.nickname = ""
    tb.status = 0
    tb.head = 0
    tb.level = 0
    tb.public = ""
    tb.battle_prop = {}
    tb.potence_level = 0
    tb.advanced_level = 0

    tb.encode = function(byteArray)
    	byteArray.write_string(tb.nickname)
    	byteArray.write_int(tb.status)
    	byteArray.write_int(tb.head)
    	byteArray.write_int(tb.level)
    	byteArray.write_string(tb.public)
        tb.battle_prop.encode(byteArray);
    	byteArray.write_int(tb.potence_level)
    	byteArray.write_int(tb.advanced_level)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.nickname = byteArray.read_string();
        tb.status = byteArray.read_int();
        tb.head = byteArray.read_int();
        tb.level = byteArray.read_int();
        tb.public = byteArray.read_string();
        tb.battle_prop = battle_info();
        tb.battle_prop.decode(byteArray);
        tb.potence_level = byteArray.read_int();
        tb.advanced_level = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_friend_data"])
        return tb.encode(byteArray)
    end

    return tb

end

function friend_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_friend_info"]
    end
    tb.friend_id = 0
    tb.nickname = ""
    tb.status = 0
    tb.head = 0
    tb.level = 0
    tb.public = ""
    tb.battle_prop = {}
    tb.potence_level = 0
    tb.advanced_level = 0
    tb.my_send_status = 0
    tb.friend_send_status = 0
    tb.is_comrade = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.friend_id)
    	byteArray.write_string(tb.nickname)
    	byteArray.write_int(tb.status)
    	byteArray.write_int(tb.head)
    	byteArray.write_int(tb.level)
    	byteArray.write_string(tb.public)
        tb.battle_prop.encode(byteArray);
    	byteArray.write_int(tb.potence_level)
    	byteArray.write_int(tb.advanced_level)
    	byteArray.write_int(tb.my_send_status)
    	byteArray.write_int(tb.friend_send_status)
    	byteArray.write_int(tb.is_comrade)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.friend_id = byteArray.read_uint64();
        tb.nickname = byteArray.read_string();
        tb.status = byteArray.read_int();
        tb.head = byteArray.read_int();
        tb.level = byteArray.read_int();
        tb.public = byteArray.read_string();
        tb.battle_prop = battle_info();
        tb.battle_prop.decode(byteArray);
        tb.potence_level = byteArray.read_int();
        tb.advanced_level = byteArray.read_int();
        tb.my_send_status = byteArray.read_int();
        tb.friend_send_status = byteArray.read_int();
        tb.is_comrade = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_friend_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function award_item ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_award_item"]
    end
    tb.temp_id = 0
    tb.amount = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.temp_id)
    	byteArray.write_int(tb.amount)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.temp_id = byteArray.read_int();
        tb.amount = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_award_item"])
        return tb.encode(byteArray)
    end

    return tb

end

function challenge_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_challenge_info"]
    end
    tb.name = ""
    tb.result = 0
    tb.new_rank = 0

    tb.encode = function(byteArray)
    	byteArray.write_string(tb.name)
    	byteArray.write_int(tb.result)
    	byteArray.write_int(tb.new_rank)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.name = byteArray.read_string();
        tb.result = byteArray.read_int();
        tb.new_rank = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_challenge_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function rank_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_rank_info"]
    end
    tb.role_id = 0
    tb.name = ""
    tb.type = 0
    tb.rank = 0
    tb.level = 0
    tb.potence_level = 0
    tb.advanced_level = 0
    tb.power = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.role_id)
    	byteArray.write_string(tb.name)
    	byteArray.write_int(tb.type)
    	byteArray.write_int(tb.rank)
    	byteArray.write_int(tb.level)
    	byteArray.write_int(tb.potence_level)
    	byteArray.write_int(tb.advanced_level)
    	byteArray.write_int(tb.power)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.role_id = byteArray.read_uint64();
        tb.name = byteArray.read_string();
        tb.type = byteArray.read_int();
        tb.rank = byteArray.read_int();
        tb.level = byteArray.read_int();
        tb.potence_level = byteArray.read_int();
        tb.advanced_level = byteArray.read_int();
        tb.power = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_rank_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function train_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_train_info"]
    end
    tb.role_id = 0
    tb.name = ""
    tb.type = 0
    tb.status = 0
    tb.level = 0
    tb.potence_level = 0
    tb.advanced_level = 0
    tb.power = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.role_id)
    	byteArray.write_string(tb.name)
    	byteArray.write_int(tb.type)
    	byteArray.write_int(tb.status)
    	byteArray.write_int(tb.level)
    	byteArray.write_int(tb.potence_level)
    	byteArray.write_int(tb.advanced_level)
    	byteArray.write_int(tb.power)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.role_id = byteArray.read_uint64();
        tb.name = byteArray.read_string();
        tb.type = byteArray.read_int();
        tb.status = byteArray.read_int();
        tb.level = byteArray.read_int();
        tb.potence_level = byteArray.read_int();
        tb.advanced_level = byteArray.read_int();
        tb.power = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_train_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function rank_data ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_rank_data"]
    end
    tb.role_id = 0
    tb.name = ""
    tb.type = 0
    tb.rank = 0
    tb.value = 0
    tb.public = ""

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.role_id)
    	byteArray.write_string(tb.name)
    	byteArray.write_int(tb.type)
    	byteArray.write_int(tb.rank)
    	byteArray.write_int(tb.value)
    	byteArray.write_string(tb.public)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.role_id = byteArray.read_uint64();
        tb.name = byteArray.read_string();
        tb.type = byteArray.read_int();
        tb.rank = byteArray.read_int();
        tb.value = byteArray.read_int();
        tb.public = byteArray.read_string();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_rank_data"])
        return tb.encode(byteArray)
    end

    return tb

end

function donor ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_donor"]
    end
    tb.role_id = 0
    tb.rel = 0
    tb.level = 0
    tb.role_type = 0
    tb.nick_name = ""
    tb.friend_point = 0
    tb.power = 0
    tb.sculpture = {}
    tb.potence_level = 0
    tb.advanced_level = 0
    tb.is_used = 0
    tb.is_robot = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.role_id)
    	byteArray.write_int(tb.rel)
    	byteArray.write_int(tb.level)
    	byteArray.write_int(tb.role_type)
    	byteArray.write_string(tb.nick_name)
    	byteArray.write_int(tb.friend_point)
    	byteArray.write_int(tb.power)
        tb.sculpture.encode(byteArray);
    	byteArray.write_int(tb.potence_level)
    	byteArray.write_int(tb.advanced_level)
    	byteArray.write_int(tb.is_used)
    	byteArray.write_int(tb.is_robot)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.role_id = byteArray.read_uint64();
        tb.rel = byteArray.read_int();
        tb.level = byteArray.read_int();
        tb.role_type = byteArray.read_int();
        tb.nick_name = byteArray.read_string();
        tb.friend_point = byteArray.read_int();
        tb.power = byteArray.read_int();
        tb.sculpture = sculpture_data();
        tb.sculpture.decode(byteArray);
        tb.potence_level = byteArray.read_int();
        tb.advanced_level = byteArray.read_int();
        tb.is_used = byteArray.read_int();
        tb.is_robot = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_donor"])
        return tb.encode(byteArray)
    end

    return tb

end

function mall_buy_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_mall_buy_info"]
    end
    tb.mallitem_id = 0
    tb.times = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.mallitem_id)
    	byteArray.write_int(tb.times)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.mallitem_id = byteArray.read_int();
        tb.times = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_mall_buy_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function lottery_item ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_lottery_item"]
    end
    tb.reward_id = 0
    tb.amount = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.reward_id)
    	byteArray.write_int(tb.amount)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.reward_id = byteArray.read_int();
        tb.amount = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_lottery_item"])
        return tb.encode(byteArray)
    end

    return tb

end

function friend_point_lottery_item ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_friend_point_lottery_item"]
    end
    tb.id = 0
    tb.amount = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.id)
    	byteArray.write_int(tb.amount)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.id = byteArray.read_int();
        tb.amount = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_friend_point_lottery_item"])
        return tb.encode(byteArray)
    end

    return tb

end

function activeness_task_item ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_activeness_task_item"]
    end
    tb.id = 0
    tb.count = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.id)
    	byteArray.write_int(tb.count)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.id = byteArray.read_int();
        tb.count = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_activeness_task_item"])
        return tb.encode(byteArray)
    end

    return tb

end

function material_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_material_info"]
    end
    tb.material_id = 0
    tb.amount = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.material_id)
    	byteArray.write_int(tb.amount)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.material_id = byteArray.read_int();
        tb.amount = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_material_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function clean_up_trophy ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_clean_up_trophy"]
    end
    tb.item = {}
    tb.gold = 0
    tb.exp = 0

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.item))
        for k, v in pairs(tb.item) do
            byteArray = v.encode(byteArray)
        end
    	byteArray.write_int(tb.gold)
    	byteArray.write_int(tb.exp)
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOfitem = byteArray.read_uint16()
        tb.item = {}
        for i = 1, countOfitem do
            local temp = mons_item()
            temp.decode(byteArray)
            table.insert(tb.item, temp)
        end
        tb.gold = byteArray.read_int();
        tb.exp = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_clean_up_trophy"])
        return tb.encode(byteArray)
    end

    return tb

end

function semail ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_semail"]
    end
    tb.id = 0
    tb.type = 0
    tb.title = ""
    tb.content = ""
    tb.attachments = {}
    tb.recv_time = {}
    tb.end_time = {}

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.id)
    	byteArray.write_uchar(tb.type)
    	byteArray.write_string(tb.title)
    	byteArray.write_string(tb.content)
        byteArray.write_uint16(#(tb.attachments))
        for k, v in pairs(tb.attachments) do
            byteArray = v.encode(byteArray)
        end
        tb.recv_time.encode(byteArray);
        tb.end_time.encode(byteArray);
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.id = byteArray.read_int();
        tb.type = byteArray.read_uchar();
        tb.title = byteArray.read_string();
        tb.content = byteArray.read_string();
        local countOfattachments = byteArray.read_uint16()
        tb.attachments = {}
        for i = 1, countOfattachments do
            local temp = award_item()
            temp.decode(byteArray)
            table.insert(tb.attachments, temp)
        end
        tb.recv_time = stime();
        tb.recv_time.decode(byteArray);
        tb.end_time = stime();
        tb.end_time.decode(byteArray);
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_semail"])
        return tb.encode(byteArray)
    end

    return tb

end

function leave_msg ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_leave_msg"]
    end
    tb.role_id = 0
    tb.msg = ""

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.role_id)
    	byteArray.write_string(tb.msg)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.role_id = byteArray.read_uint64();
        tb.msg = byteArray.read_string();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_leave_msg"])
        return tb.encode(byteArray)
    end

    return tb

end

function master_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_master_info"]
    end
    tb.role_id = 0
    tb.name = ""
    tb.type = 0
    tb.advanced_level = 0
    tb.battle_power = 0
    tb.level = 0
    tb.status = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.role_id)
    	byteArray.write_string(tb.name)
    	byteArray.write_int(tb.type)
    	byteArray.write_int(tb.advanced_level)
    	byteArray.write_int(tb.battle_power)
    	byteArray.write_int(tb.level)
    	byteArray.write_int(tb.status)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.role_id = byteArray.read_uint64();
        tb.name = byteArray.read_string();
        tb.type = byteArray.read_int();
        tb.advanced_level = byteArray.read_int();
        tb.battle_power = byteArray.read_int();
        tb.level = byteArray.read_int();
        tb.status = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_master_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function prentice_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_prentice_info"]
    end
    tb.role_id = 0
    tb.name = ""
    tb.type = 0
    tb.advanced_level = 0
    tb.level = 0
    tb.rewarded_list = {}
    tb.status = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.role_id)
    	byteArray.write_string(tb.name)
    	byteArray.write_int(tb.type)
    	byteArray.write_int(tb.advanced_level)
    	byteArray.write_int(tb.level)
        byteArray.write_uint16(#(tb.rewarded_list))
        for k, v in pairs (tb.rewarded_list) do
            byteArray.write_int(v)
        end
    	byteArray.write_int(tb.status)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.role_id = byteArray.read_uint64();
        tb.name = byteArray.read_string();
        tb.type = byteArray.read_int();
        tb.advanced_level = byteArray.read_int();
        tb.level = byteArray.read_int();
        local countOfrewarded_list = byteArray.read_uint16()
        tb.rewarded_list = {}
        for i = 1, countOfrewarded_list do
             table.insert(tb.rewarded_list, byteArray.read_int())
        end
        tb.status = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_prentice_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function skill_group_item ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_skill_group_item"]
    end
    tb.id1 = 0
    tb.id2 = 0
    tb.id3 = 0
    tb.id4 = 0
    tb.index = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.id1)
    	byteArray.write_int(tb.id2)
    	byteArray.write_int(tb.id3)
    	byteArray.write_int(tb.id4)
    	byteArray.write_int(tb.index)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.id1 = byteArray.read_int();
        tb.id2 = byteArray.read_int();
        tb.id3 = byteArray.read_int();
        tb.id4 = byteArray.read_int();
        tb.index = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_skill_group_item"])
        return tb.encode(byteArray)
    end

    return tb

end

function notice_list_item ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notice_list_item"]
    end
    tb.id = 0
    tb.title = ""
    tb.sub_title = ""
    tb.icon = 0
    tb.mark_id = 0
    tb.create_time = {}
    tb.priority = 0
    tb.top_pic = 0
    tb.start_time = {}
    tb.end_time = {}

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.id)
    	byteArray.write_string(tb.title)
    	byteArray.write_string(tb.sub_title)
    	byteArray.write_int(tb.icon)
    	byteArray.write_int(tb.mark_id)
        tb.create_time.encode(byteArray);
    	byteArray.write_int(tb.priority)
    	byteArray.write_int(tb.top_pic)
        tb.start_time.encode(byteArray);
        tb.end_time.encode(byteArray);
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.id = byteArray.read_int();
        tb.title = byteArray.read_string();
        tb.sub_title = byteArray.read_string();
        tb.icon = byteArray.read_int();
        tb.mark_id = byteArray.read_int();
        tb.create_time = stime();
        tb.create_time.decode(byteArray);
        tb.priority = byteArray.read_int();
        tb.top_pic = byteArray.read_int();
        tb.start_time = stime();
        tb.start_time.decode(byteArray);
        tb.end_time = stime();
        tb.end_time.decode(byteArray);
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notice_list_item"])
        return tb.encode(byteArray)
    end

    return tb

end

function notice_item_detail ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notice_item_detail"]
    end
    tb.id = 0
    tb.title = ""
    tb.sub_title = ""
    tb.icon = 0
    tb.content = ""
    tb.toward_id = 0
    tb.mark_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.id)
    	byteArray.write_string(tb.title)
    	byteArray.write_string(tb.sub_title)
    	byteArray.write_int(tb.icon)
    	byteArray.write_string(tb.content)
    	byteArray.write_int(tb.toward_id)
    	byteArray.write_int(tb.mark_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.id = byteArray.read_int();
        tb.title = byteArray.read_string();
        tb.sub_title = byteArray.read_string();
        tb.icon = byteArray.read_int();
        tb.content = byteArray.read_string();
        tb.toward_id = byteArray.read_int();
        tb.mark_id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notice_item_detail"])
        return tb.encode(byteArray)
    end

    return tb

end

function time_limit_rewarded_item ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_time_limit_rewarded_item"]
    end
    tb.id = 0
    tb.count = 0
    tb.rewarded_time = {}

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.id)
    	byteArray.write_int(tb.count)
        tb.rewarded_time.encode(byteArray);
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.id = byteArray.read_int();
        tb.count = byteArray.read_int();
        tb.rewarded_time = stime();
        tb.rewarded_time.decode(byteArray);
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_time_limit_rewarded_item"])
        return tb.encode(byteArray)
    end

    return tb

end

function role_life_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_role_life_info"]
    end
    tb.role_id = 0
    tb.cur_life = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.role_id)
    	byteArray.write_int(tb.cur_life)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.role_id = byteArray.read_uint64();
        tb.cur_life = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_role_life_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function lottery_progress_item ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_lottery_progress_item"]
    end
    tb.id = 0
    tb.cur_count = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.id)
    	byteArray.write_int(tb.cur_count)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.id = byteArray.read_int();
        tb.cur_count = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_lottery_progress_item"])
        return tb.encode(byteArray)
    end

    return tb

end

function activity_item ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_activity_item"]
    end
    tb.id = 0
    tb.remain_seconds = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.id)
    	byteArray.write_int(tb.remain_seconds)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.id = byteArray.read_int();
        tb.remain_seconds = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_activity_item"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_heartbeat ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_heartbeat"]
    end
    tb.version = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.version)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.version = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_heartbeat"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_socket_close ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_socket_close"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_socket_close"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_repeat_login ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_repeat_login"]
    end
    tb.account = ""

    tb.encode = function(byteArray)
    	byteArray.write_string(tb.account)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.account = byteArray.read_string();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_repeat_login"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_register ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_register"]
    end
    tb.account = ""
    tb.channelid = 0
    tb.platformid = 0
    tb.password = ""

    tb.encode = function(byteArray)
    	byteArray.write_string(tb.account)
    	byteArray.write_int(tb.channelid)
    	byteArray.write_int(tb.platformid)
    	byteArray.write_string(tb.password)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.account = byteArray.read_string();
        tb.channelid = byteArray.read_int();
        tb.platformid = byteArray.read_int();
        tb.password = byteArray.read_string();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_register"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_register_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_register_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_register_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_create_role ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_create_role"]
    end
    tb.roletype = 0
    tb.nickname = ""

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.roletype)
    	byteArray.write_string(tb.nickname)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.roletype = byteArray.read_int();
        tb.nickname = byteArray.read_string();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_create_role"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_create_role_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_create_role_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_create_role_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_roleinfo_msg ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_roleinfo_msg"]
    end
    tb.id = 0
    tb.nickname = ""
    tb.role_status = 0
    tb.roletype = 0
    tb.armor = 0
    tb.weapon = 0
    tb.ring = 0
    tb.necklace = 0
    tb.medal = 0
    tb.jewelry = 0
    tb.skill1 = 0
    tb.skill2 = 0
    tb.skill_group_index = 0
    tb.level = 0
    tb.exp = 0
    tb.gold = 0
    tb.emoney = 0
    tb.summon_stone = 0
    tb.power_hp = 0
    tb.recover_time_left = 0
    tb.power_hp_buy_times = 0
    tb.pack_space = 0
    tb.friend_point = 0
    tb.point = 0
    tb.honour = 0
    tb.battle_power = 0
    tb.alchemy_exp = 0
    tb.battle_soul = 0
    tb.potence_level = 0
    tb.advanced_level = 0
    tb.vip_level = 0
    tb.vip_exp = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.id)
    	byteArray.write_string(tb.nickname)
    	byteArray.write_int(tb.role_status)
    	byteArray.write_int(tb.roletype)
    	byteArray.write_uint64(tb.armor)
    	byteArray.write_uint64(tb.weapon)
    	byteArray.write_uint64(tb.ring)
    	byteArray.write_uint64(tb.necklace)
    	byteArray.write_uint64(tb.medal)
    	byteArray.write_uint64(tb.jewelry)
    	byteArray.write_int(tb.skill1)
    	byteArray.write_int(tb.skill2)
    	byteArray.write_int(tb.skill_group_index)
    	byteArray.write_int(tb.level)
    	byteArray.write_int(tb.exp)
    	byteArray.write_int(tb.gold)
    	byteArray.write_int(tb.emoney)
    	byteArray.write_int(tb.summon_stone)
    	byteArray.write_int(tb.power_hp)
    	byteArray.write_int(tb.recover_time_left)
    	byteArray.write_int(tb.power_hp_buy_times)
    	byteArray.write_int(tb.pack_space)
    	byteArray.write_int(tb.friend_point)
    	byteArray.write_int(tb.point)
    	byteArray.write_int(tb.honour)
    	byteArray.write_int(tb.battle_power)
    	byteArray.write_int(tb.alchemy_exp)
    	byteArray.write_int(tb.battle_soul)
    	byteArray.write_int(tb.potence_level)
    	byteArray.write_int(tb.advanced_level)
    	byteArray.write_int(tb.vip_level)
    	byteArray.write_int(tb.vip_exp)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.id = byteArray.read_uint64();
        tb.nickname = byteArray.read_string();
        tb.role_status = byteArray.read_int();
        tb.roletype = byteArray.read_int();
        tb.armor = byteArray.read_uint64();
        tb.weapon = byteArray.read_uint64();
        tb.ring = byteArray.read_uint64();
        tb.necklace = byteArray.read_uint64();
        tb.medal = byteArray.read_uint64();
        tb.jewelry = byteArray.read_uint64();
        tb.skill1 = byteArray.read_int();
        tb.skill2 = byteArray.read_int();
        tb.skill_group_index = byteArray.read_int();
        tb.level = byteArray.read_int();
        tb.exp = byteArray.read_int();
        tb.gold = byteArray.read_int();
        tb.emoney = byteArray.read_int();
        tb.summon_stone = byteArray.read_int();
        tb.power_hp = byteArray.read_int();
        tb.recover_time_left = byteArray.read_int();
        tb.power_hp_buy_times = byteArray.read_int();
        tb.pack_space = byteArray.read_int();
        tb.friend_point = byteArray.read_int();
        tb.point = byteArray.read_int();
        tb.honour = byteArray.read_int();
        tb.battle_power = byteArray.read_int();
        tb.alchemy_exp = byteArray.read_int();
        tb.battle_soul = byteArray.read_int();
        tb.potence_level = byteArray.read_int();
        tb.advanced_level = byteArray.read_int();
        tb.vip_level = byteArray.read_int();
        tb.vip_exp = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_roleinfo_msg"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_clean_up_copy ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_clean_up_copy"]
    end
    tb.copy_id = 0
    tb.count = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.copy_id)
    	byteArray.write_int(tb.count)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.copy_id = byteArray.read_int();
        tb.count = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_clean_up_copy"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_clean_up_copy_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_clean_up_copy_result"]
    end
    tb.result = 0
    tb.trophy_list = {}

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        byteArray.write_uint16(#(tb.trophy_list))
        for k, v in pairs(tb.trophy_list) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        local countOftrophy_list = byteArray.read_uint16()
        tb.trophy_list = {}
        for i = 1, countOftrophy_list do
            local temp = clean_up_trophy()
            temp.decode(byteArray)
            table.insert(tb.trophy_list, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_clean_up_copy_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_enter_game ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_enter_game"]
    end
    tb.id = 0
    tb.gametype = 0
    tb.copy_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.id)
    	byteArray.write_int(tb.gametype)
    	byteArray.write_int(tb.copy_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.id = byteArray.read_uint64();
        tb.gametype = byteArray.read_int();
        tb.copy_id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_enter_game"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_enter_game ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_enter_game"]
    end
    tb.result = 0
    tb.game_id = 0
    tb.gamemaps = {}

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
    	byteArray.write_uint64(tb.game_id)
        byteArray.write_uint16(#(tb.gamemaps))
        for k, v in pairs(tb.gamemaps) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.game_id = byteArray.read_uint64();
        local countOfgamemaps = byteArray.read_uint16()
        tb.gamemaps = {}
        for i = 1, countOfgamemaps do
            local temp = game_map()
            temp.decode(byteArray)
            table.insert(tb.gamemaps, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_enter_game"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_last_copy ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_last_copy"]
    end
    tb.last_copy_id = 0
    tb.copyinfos = {}

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.last_copy_id)
        byteArray.write_uint16(#(tb.copyinfos))
        for k, v in pairs(tb.copyinfos) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.last_copy_id = byteArray.read_int();
        local countOfcopyinfos = byteArray.read_uint16()
        tb.copyinfos = {}
        for i = 1, countOfcopyinfos do
            local temp = copy_info()
            temp.decode(byteArray)
            table.insert(tb.copyinfos, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_last_copy"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_last_copy ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_last_copy"]
    end
    tb.roleid = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.roleid)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.roleid = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_last_copy"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_buy_power_hp ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_buy_power_hp"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_buy_power_hp"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_buy_power_hp_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_buy_power_hp_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_buy_power_hp_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_power_hp_msg ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_power_hp_msg"]
    end
    tb.result = 0
    tb.power_hp = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
    	byteArray.write_int(tb.power_hp)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.power_hp = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_power_hp_msg"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_player_pack ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_player_pack"]
    end
    tb.type = 0
    tb.pack_items = {}

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.type)
        byteArray.write_uint16(#(tb.pack_items))
        for k, v in pairs(tb.pack_items) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.type = byteArray.read_int();
        local countOfpack_items = byteArray.read_uint16()
        tb.pack_items = {}
        for i = 1, countOfpack_items do
            local temp = pack_item()
            temp.decode(byteArray)
            table.insert(tb.pack_items, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_player_pack"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_game_settle ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_game_settle"]
    end
    tb.game_id = 0
    tb.result = 0
    tb.life = 0
    tb.maxlife = 0
    tb.cost_round = 0
    tb.pickup_items = {}
    tb.user_operations = {}
    tb.gold = 0
    tb.killmonsters = {}

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.game_id)
    	byteArray.write_int(tb.result)
    	byteArray.write_int(tb.life)
    	byteArray.write_int(tb.maxlife)
    	byteArray.write_int(tb.cost_round)
        byteArray.write_uint16(#(tb.pickup_items))
        for k, v in pairs(tb.pickup_items) do
            byteArray = v.encode(byteArray)
        end
        byteArray.write_uint16(#(tb.user_operations))
        for k, v in pairs (tb.user_operations) do
            byteArray.write_int(v)
        end
    	byteArray.write_int(tb.gold)
        byteArray.write_uint16(#(tb.killmonsters))
        for k, v in pairs (tb.killmonsters) do
            byteArray.write_int(v)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.game_id = byteArray.read_uint64();
        tb.result = byteArray.read_int();
        tb.life = byteArray.read_int();
        tb.maxlife = byteArray.read_int();
        tb.cost_round = byteArray.read_int();
        local countOfpickup_items = byteArray.read_uint16()
        tb.pickup_items = {}
        for i = 1, countOfpickup_items do
            local temp = mons_item()
            temp.decode(byteArray)
            table.insert(tb.pickup_items, temp)
        end
        local countOfuser_operations = byteArray.read_uint16()
        tb.user_operations = {}
        for i = 1, countOfuser_operations do
             table.insert(tb.user_operations, byteArray.read_int())
        end
        tb.gold = byteArray.read_int();
        local countOfkillmonsters = byteArray.read_uint16()
        tb.killmonsters = {}
        for i = 1, countOfkillmonsters do
             table.insert(tb.killmonsters, byteArray.read_int())
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_game_settle"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_game_settle ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_game_settle"]
    end
    tb.game_id = 0
    tb.result = 0
    tb.score = 0
    tb.final_item = {}
    tb.ratio_items = {}

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.game_id)
    	byteArray.write_int(tb.result)
    	byteArray.write_int(tb.score)
        tb.final_item.encode(byteArray);
        byteArray.write_uint16(#(tb.ratio_items))
        for k, v in pairs(tb.ratio_items) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.game_id = byteArray.read_uint64();
        tb.result = byteArray.read_int();
        tb.score = byteArray.read_int();
        tb.final_item = lottery_item();
        tb.final_item.decode(byteArray);
        local countOfratio_items = byteArray.read_uint16()
        tb.ratio_items = {}
        for i = 1, countOfratio_items do
            local temp = lottery_item()
            temp.decode(byteArray)
            table.insert(tb.ratio_items, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_game_settle"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_game_lottery ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_game_lottery"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_game_lottery"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_game_lottery ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_game_lottery"]
    end
    tb.second_item = {}
    tb.result = 0

    tb.encode = function(byteArray)
        tb.second_item.encode(byteArray);
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.second_item = lottery_item();
        tb.second_item.decode(byteArray);
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_game_lottery"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_game_reconnect ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_game_reconnect"]
    end
    tb.uid = ""
    tb.token = ""
    tb.role_id = 0
    tb.last_recv_stepnum = 0

    tb.encode = function(byteArray)
    	byteArray.write_string(tb.uid)
    	byteArray.write_string(tb.token)
    	byteArray.write_uint64(tb.role_id)
    	byteArray.write_int(tb.last_recv_stepnum)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.uid = byteArray.read_string();
        tb.token = byteArray.read_string();
        tb.role_id = byteArray.read_uint64();
        tb.last_recv_stepnum = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_game_reconnect"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_reconnect_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_reconnect_result"]
    end
    tb.id = 0
    tb.result = 0
    tb.last_recv_stepnum = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.id)
    	byteArray.write_int(tb.result)
    	byteArray.write_int(tb.last_recv_stepnum)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.id = byteArray.read_uint64();
        tb.result = byteArray.read_int();
        tb.last_recv_stepnum = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_reconnect_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_equipment_strengthen ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_equipment_strengthen"]
    end
    tb.equipment_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.equipment_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.equipment_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_equipment_strengthen"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_equipment_strengthen_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_equipment_strengthen_result"]
    end
    tb.strengthen_result = 0
    tb.gold = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.strengthen_result)
    	byteArray.write_int(tb.gold)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.strengthen_result = byteArray.read_int();
        tb.gold = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_equipment_strengthen_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_one_touch_equipment_strengthen ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_one_touch_equipment_strengthen"]
    end
    tb.equipment_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.equipment_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.equipment_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_one_touch_equipment_strengthen"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_one_touch_equipment_strengthen_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_one_touch_equipment_strengthen_result"]
    end
    tb.result_list = {}

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.result_list))
        for k, v in pairs(tb.result_list) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOfresult_list = byteArray.read_uint16()
        tb.result_list = {}
        for i = 1, countOfresult_list do
            local temp = notify_equipment_strengthen_result()
            temp.decode(byteArray)
            table.insert(tb.result_list, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_one_touch_equipment_strengthen_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_equipment_mountgem ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_equipment_mountgem"]
    end
    tb.equipment_id = 0
    tb.gem_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.equipment_id)
    	byteArray.write_uint64(tb.gem_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.equipment_id = byteArray.read_uint64();
        tb.gem_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_equipment_mountgem"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_equipment_mountgem_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_equipment_mountgem_result"]
    end
    tb.mountgem_result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.mountgem_result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.mountgem_result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_equipment_mountgem_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_equipment_puton ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_equipment_puton"]
    end
    tb.equipment_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.equipment_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.equipment_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_equipment_puton"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_equipment_puton_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_equipment_puton_result"]
    end
    tb.puton_result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.puton_result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.puton_result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_equipment_puton_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_equipment_infos ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_equipment_infos"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_equipment_infos"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_equipment_infos ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_equipment_infos"]
    end
    tb.type = 0
    tb.equipment_infos = {}

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.type)
        byteArray.write_uint16(#(tb.equipment_infos))
        for k, v in pairs(tb.equipment_infos) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.type = byteArray.read_int();
        local countOfequipment_infos = byteArray.read_uint16()
        tb.equipment_infos = {}
        for i = 1, countOfequipment_infos do
            local temp = equipmentinfo()
            temp.decode(byteArray)
            table.insert(tb.equipment_infos, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_equipment_infos"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_equipment_takeoff ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_equipment_takeoff"]
    end
    tb.position = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.position)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.position = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_equipment_takeoff"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_equipment_takeoff_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_equipment_takeoff_result"]
    end
    tb.takeoff_result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.takeoff_result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.takeoff_result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_equipment_takeoff_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_gold_update ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_gold_update"]
    end
    tb.gold = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.gold)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.gold = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_gold_update"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_emoney_update ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_emoney_update"]
    end
    tb.emoney = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.emoney)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.emoney = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_emoney_update"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_summon_stone_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_summon_stone_info"]
    end
    tb.is_award = 0
    tb.has_buy_times = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.is_award)
    	byteArray.write_int(tb.has_buy_times)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.is_award = byteArray.read_int();
        tb.has_buy_times = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_summon_stone_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_daily_summon_stone ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_daily_summon_stone"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_daily_summon_stone"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_daily_summon_stone ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_daily_summon_stone"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_daily_summon_stone"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_buy_summon_stone ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_buy_summon_stone"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_buy_summon_stone"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_buy_summon_stone ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_buy_summon_stone"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_buy_summon_stone"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_player_pack_exceeded ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_player_pack_exceeded"]
    end
    tb.new_extra = {}

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.new_extra))
        for k, v in pairs(tb.new_extra) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOfnew_extra = byteArray.read_uint16()
        tb.new_extra = {}
        for i = 1, countOfnew_extra do
            local temp = extra_item()
            temp.decode(byteArray)
            table.insert(tb.new_extra, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_player_pack_exceeded"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_extend_pack ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_extend_pack"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_extend_pack"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_extend_pack_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_extend_pack_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_extend_pack_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_sale_item ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_sale_item"]
    end
    tb.inst_id = 0
    tb.amount = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.inst_id)
    	byteArray.write_int(tb.amount)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.inst_id = byteArray.read_uint64();
        tb.amount = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_sale_item"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_sale_item_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_sale_item_result"]
    end
    tb.result = 0
    tb.gold = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
    	byteArray.write_int(tb.gold)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.gold = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_sale_item_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_sale_items ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_sale_items"]
    end
    tb.inst_id = {}

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.inst_id))
        for k, v in pairs (tb.inst_id) do
            byteArray.write_uint64(v)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOfinst_id = byteArray.read_uint16()
        tb.inst_id = {}
        for i = 1, countOfinst_id do
             table.insert(tb.inst_id, byteArray.read_uint64())
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_sale_items"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_sale_items_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_sale_items_result"]
    end
    tb.result = 0
    tb.err_id = 0
    tb.gold = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
    	byteArray.write_uint64(tb.err_id)
    	byteArray.write_int(tb.gold)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.err_id = byteArray.read_uint64();
        tb.gold = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_sale_items_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_search_friend ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_search_friend"]
    end
    tb.nickname = ""

    tb.encode = function(byteArray)
    	byteArray.write_string(tb.nickname)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.nickname = byteArray.read_string();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_search_friend"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_search_friend_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_search_friend_result"]
    end
    tb.result = 0
    tb.role_info = {}

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        tb.role_info.encode(byteArray);
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.role_info = friend_info();
        tb.role_info.decode(byteArray);
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_search_friend_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_add_friend ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_add_friend"]
    end
    tb.friend_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.friend_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.friend_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_add_friend"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_add_friend_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_add_friend_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_add_friend_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_req_for_add_friend ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_req_for_add_friend"]
    end
    tb.friend_id = 0
    tb.role_data = {}

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.friend_id)
        tb.role_data.encode(byteArray);
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.friend_id = byteArray.read_uint64();
        tb.role_data = friend_data();
        tb.role_data.decode(byteArray);
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_req_for_add_friend"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_proc_reqfor_add_friend ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_proc_reqfor_add_friend"]
    end
    tb.answer = 0
    tb.friend_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.answer)
    	byteArray.write_uint64(tb.friend_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.answer = byteArray.read_int();
        tb.friend_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_proc_reqfor_add_friend"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_del_friend ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_del_friend"]
    end
    tb.friend_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.friend_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.friend_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_del_friend"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_del_friend_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_del_friend_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_del_friend_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_get_friends ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_get_friends"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_get_friends"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_friend_list ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_friend_list"]
    end
    tb.type = 0
    tb.friends = {}

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.type)
        byteArray.write_uint16(#(tb.friends))
        for k, v in pairs(tb.friends) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.type = byteArray.read_int();
        local countOffriends = byteArray.read_uint16()
        tb.friends = {}
        for i = 1, countOffriends do
            local temp = friend_info()
            temp.decode(byteArray)
            table.insert(tb.friends, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_friend_list"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_get_makefriend_reqs ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_get_makefriend_reqs"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_get_makefriend_reqs"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_makefriend_reqs ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_makefriend_reqs"]
    end
    tb.reqs = {}

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.reqs))
        for k, v in pairs(tb.reqs) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOfreqs = byteArray.read_uint16()
        tb.reqs = {}
        for i = 1, countOfreqs do
            local temp = friend_info()
            temp.decode(byteArray)
            table.insert(tb.reqs, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_makefriend_reqs"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_makefriend_reqs_amount ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_makefriend_reqs_amount"]
    end
    tb.amount = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.amount)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.amount = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_makefriend_reqs_amount"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_leave_msg_count ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_leave_msg_count"]
    end
    tb.count = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.count)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.count = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_leave_msg_count"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_msg_list ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_msg_list"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_msg_list"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_msg_list ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_msg_list"]
    end
    tb.msg_list = {}

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.msg_list))
        for k, v in pairs(tb.msg_list) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOfmsg_list = byteArray.read_uint16()
        tb.msg_list = {}
        for i = 1, countOfmsg_list do
            local temp = leave_msg()
            temp.decode(byteArray)
            table.insert(tb.msg_list, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_msg_list"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_send_chat_msg ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_send_chat_msg"]
    end
    tb.friend_id = 0
    tb.chat_msg = ""

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.friend_id)
    	byteArray.write_string(tb.chat_msg)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.friend_id = byteArray.read_uint64();
        tb.chat_msg = byteArray.read_string();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_send_chat_msg"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_send_chat_msg_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_send_chat_msg_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_send_chat_msg_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_receive_chat_msg ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_receive_chat_msg"]
    end
    tb.friend_id = 0
    tb.chat_msg = ""

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.friend_id)
    	byteArray.write_string(tb.chat_msg)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.friend_id = byteArray.read_uint64();
        tb.chat_msg = byteArray.read_string();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_receive_chat_msg"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_push_tower_map_settle ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_push_tower_map_settle"]
    end
    tb.game_id = 0
    tb.result = 0
    tb.cost_round = 0
    tb.life = 0
    tb.pickup_items = {}
    tb.drop_gold = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.game_id)
    	byteArray.write_int(tb.result)
    	byteArray.write_int(tb.cost_round)
    	byteArray.write_int(tb.life)
        byteArray.write_uint16(#(tb.pickup_items))
        for k, v in pairs (tb.pickup_items) do
            byteArray.write_int(v)
        end
    	byteArray.write_int(tb.drop_gold)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.game_id = byteArray.read_uint64();
        tb.result = byteArray.read_int();
        tb.cost_round = byteArray.read_int();
        tb.life = byteArray.read_int();
        local countOfpickup_items = byteArray.read_uint16()
        tb.pickup_items = {}
        for i = 1, countOfpickup_items do
             table.insert(tb.pickup_items, byteArray.read_int())
        end
        tb.drop_gold = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_push_tower_map_settle"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_push_tower_map_settle ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_push_tower_map_settle"]
    end
    tb.result = 0
    tb.gamemap = {}
    tb.awards = {}
    tb.gold = 0
    tb.exp = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        byteArray.write_uint16(#(tb.gamemap))
        for k, v in pairs(tb.gamemap) do
            byteArray = v.encode(byteArray)
        end
        byteArray.write_uint16(#(tb.awards))
        for k, v in pairs(tb.awards) do
            byteArray = v.encode(byteArray)
        end
    	byteArray.write_int(tb.gold)
    	byteArray.write_int(tb.exp)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        local countOfgamemap = byteArray.read_uint16()
        tb.gamemap = {}
        for i = 1, countOfgamemap do
            local temp = game_map()
            temp.decode(byteArray)
            table.insert(tb.gamemap, temp)
        end
        local countOfawards = byteArray.read_uint16()
        tb.awards = {}
        for i = 1, countOfawards do
            local temp = award_item()
            temp.decode(byteArray)
            table.insert(tb.awards, temp)
        end
        tb.gold = byteArray.read_int();
        tb.exp = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_push_tower_map_settle"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_push_tower_buy_round ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_push_tower_buy_round"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_push_tower_buy_round"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_push_tower_buy_round ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_push_tower_buy_round"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_push_tower_buy_round"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_push_tower_buy_playtimes ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_push_tower_buy_playtimes"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_push_tower_buy_playtimes"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_push_tower_buy_playtimes ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_push_tower_buy_playtimes"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_push_tower_buy_playtimes"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_reborn ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_reborn"]
    end
    tb.type = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.type)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.type = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_reborn"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_reborn_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_reborn_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_reborn_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_auto_fight ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_auto_fight"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_auto_fight"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_auto_fight_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_auto_fight_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_auto_fight_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_gem_compound ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_gem_compound"]
    end
    tb.temp_id = 0
    tb.is_protect = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.temp_id)
    	byteArray.write_int(tb.is_protect)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.temp_id = byteArray.read_int();
        tb.is_protect = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_gem_compound"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_gem_compound_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_gem_compound_result"]
    end
    tb.result = 0
    tb.lost_gem_amount = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
    	byteArray.write_int(tb.lost_gem_amount)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.lost_gem_amount = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_gem_compound_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_one_touch_gem_compound ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_one_touch_gem_compound"]
    end
    tb.temp_id = 0
    tb.is_protect = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.temp_id)
    	byteArray.write_int(tb.is_protect)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.temp_id = byteArray.read_int();
        tb.is_protect = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_one_touch_gem_compound"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_one_touch_gem_compound_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_one_touch_gem_compound_result"]
    end
    tb.result_list = {}

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.result_list))
        for k, v in pairs(tb.result_list) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOfresult_list = byteArray.read_uint16()
        tb.result_list = {}
        for i = 1, countOfresult_list do
            local temp = notify_gem_compound_result()
            temp.decode(byteArray)
            table.insert(tb.result_list, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_one_touch_gem_compound_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_gem_unmounted ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_gem_unmounted"]
    end
    tb.equipment_id = 0
    tb.gem_temp_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.equipment_id)
    	byteArray.write_int(tb.gem_temp_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.equipment_id = byteArray.read_uint64();
        tb.gem_temp_id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_gem_unmounted"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_gem_unmounted_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_gem_unmounted_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_gem_unmounted_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_push_tower_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_push_tower_info"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_push_tower_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_push_tower_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_push_tower_info"]
    end
    tb.play_times = 0
    tb.max_times = 0
    tb.max_floor = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.play_times)
    	byteArray.write_int(tb.max_times)
    	byteArray.write_int(tb.max_floor)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.play_times = byteArray.read_int();
        tb.max_times = byteArray.read_int();
        tb.max_floor = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_push_tower_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_tutorial_progress ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_tutorial_progress"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_tutorial_progress"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_tutorial_progress ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_tutorial_progress"]
    end
    tb.progress = {}

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.progress))
        for k, v in pairs (tb.progress) do
            byteArray.write_int(v)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOfprogress = byteArray.read_uint16()
        tb.progress = {}
        for i = 1, countOfprogress do
             table.insert(tb.progress, byteArray.read_int())
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_tutorial_progress"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_set_tutorial_progress ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_set_tutorial_progress"]
    end
    tb.progress = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.progress)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.progress = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_set_tutorial_progress"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_set_tutorial_progress_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_set_tutorial_progress_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_set_tutorial_progress_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_today_activeness_task ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_today_activeness_task"]
    end
    tb.task_list = {}
    tb.is_reward_activeness_item_info = {}
    tb.activeness = 0

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.task_list))
        for k, v in pairs(tb.task_list) do
            byteArray = v.encode(byteArray)
        end
        byteArray.write_uint16(#(tb.is_reward_activeness_item_info))
        for k, v in pairs (tb.is_reward_activeness_item_info) do
            byteArray.write_int(v)
        end
    	byteArray.write_int(tb.activeness)
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOftask_list = byteArray.read_uint16()
        tb.task_list = {}
        for i = 1, countOftask_list do
            local temp = activeness_task_item()
            temp.decode(byteArray)
            table.insert(tb.task_list, temp)
        end
        local countOfis_reward_activeness_item_info = byteArray.read_uint16()
        tb.is_reward_activeness_item_info = {}
        for i = 1, countOfis_reward_activeness_item_info do
             table.insert(tb.is_reward_activeness_item_info, byteArray.read_int())
        end
        tb.activeness = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_today_activeness_task"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_today_activeness_task ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_today_activeness_task"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_today_activeness_task"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_activeness_reward ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_activeness_reward"]
    end
    tb.reward = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.reward)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.reward = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_activeness_reward"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_activeness_reward_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_activeness_reward_result"]
    end
    tb.reward = 0
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.reward)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.reward = byteArray.read_int();
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_activeness_reward_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_military_rank_reward ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_military_rank_reward"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_military_rank_reward"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_military_rank_reward_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_military_rank_reward_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_military_rank_reward_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_military_rank_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_military_rank_info"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_military_rank_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_military_rank_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_military_rank_info"]
    end
    tb.level = 0
    tb.is_rewarded = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.level)
    	byteArray.write_int(tb.is_rewarded)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.level = byteArray.read_int();
        tb.is_rewarded = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_military_rank_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_first_charge_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_first_charge_info"]
    end
    tb.status = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.status)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.status = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_first_charge_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_first_charge_reward ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_first_charge_reward"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_first_charge_reward"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_first_charge_reward_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_first_charge_reward_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_first_charge_reward_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_vip_reward_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_vip_reward_info"]
    end
    tb.level_rewarded_list = {}
    tb.daily_rewarded = 0

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.level_rewarded_list))
        for k, v in pairs (tb.level_rewarded_list) do
            byteArray.write_int(v)
        end
    	byteArray.write_int(tb.daily_rewarded)
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOflevel_rewarded_list = byteArray.read_uint16()
        tb.level_rewarded_list = {}
        for i = 1, countOflevel_rewarded_list do
             table.insert(tb.level_rewarded_list, byteArray.read_int())
        end
        tb.daily_rewarded = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_vip_reward_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_vip_grade_reward ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_vip_grade_reward"]
    end
    tb.level = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.level)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.level = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_vip_grade_reward"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_vip_grade_reward_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_vip_grade_reward_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_vip_grade_reward_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_vip_daily_reward ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_vip_daily_reward"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_vip_daily_reward"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_vip_daily_reward_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_vip_daily_reward_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_vip_daily_reward_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_recharge ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_recharge"]
    end
    tb.user_id = 0
    tb.emoney = 0
    tb.org_emoney = 0
    tb.vip_exp = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.user_id)
    	byteArray.write_int(tb.emoney)
    	byteArray.write_int(tb.org_emoney)
    	byteArray.write_int(tb.vip_exp)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.user_id = byteArray.read_int();
        tb.emoney = byteArray.read_int();
        tb.org_emoney = byteArray.read_int();
        tb.vip_exp = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_recharge"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_recharge_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_recharge_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_recharge_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function task_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_task_info"]
    end
    tb.task_id = 0
    tb.has_finished = 0
    tb.args = {}

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.task_id)
    	byteArray.write_int(tb.has_finished)
        byteArray.write_uint16(#(tb.args))
        for k, v in pairs (tb.args) do
            byteArray.write_int(v)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.task_id = byteArray.read_int();
        tb.has_finished = byteArray.read_int();
        local countOfargs = byteArray.read_uint16()
        tb.args = {}
        for i = 1, countOfargs do
             table.insert(tb.args, byteArray.read_int())
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_task_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_task_infos ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_task_infos"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_task_infos"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_task_infos ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_task_infos"]
    end
    tb.type = 0
    tb.infos = {}

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.type)
        byteArray.write_uint16(#(tb.infos))
        for k, v in pairs(tb.infos) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.type = byteArray.read_int();
        local countOfinfos = byteArray.read_uint16()
        tb.infos = {}
        for i = 1, countOfinfos do
            local temp = task_info()
            temp.decode(byteArray)
            table.insert(tb.infos, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_task_infos"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_finish_task ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_finish_task"]
    end
    tb.task_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.task_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.task_id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_finish_task"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_finish_task ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_finish_task"]
    end
    tb.is_success = 0
    tb.task_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.is_success)
    	byteArray.write_int(tb.task_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.is_success = byteArray.read_int();
        tb.task_id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_finish_task"])
        return tb.encode(byteArray)
    end

    return tb

end

function sculpture_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_sculpture_info"]
    end
    tb.temp_id = 0
    tb.value = 0
    tb.type = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.temp_id)
    	byteArray.write_int(tb.value)
    	byteArray.write_int(tb.type)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.temp_id = byteArray.read_int();
        tb.value = byteArray.read_int();
        tb.type = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_sculpture_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_sculpture_infos ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_sculpture_infos"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_sculpture_infos"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_sculpture_infos ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_sculpture_infos"]
    end
    tb.type = 0
    tb.sculpture_infos = {}

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.type)
        byteArray.write_uint16(#(tb.sculpture_infos))
        for k, v in pairs(tb.sculpture_infos) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.type = byteArray.read_int();
        local countOfsculpture_infos = byteArray.read_uint16()
        tb.sculpture_infos = {}
        for i = 1, countOfsculpture_infos do
            local temp = sculpture_info()
            temp.decode(byteArray)
            table.insert(tb.sculpture_infos, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_sculpture_infos"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_sculpture_puton ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_sculpture_puton"]
    end
    tb.group_index = 0
    tb.position = 0
    tb.temp_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.group_index)
    	byteArray.write_int(tb.position)
    	byteArray.write_int(tb.temp_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.group_index = byteArray.read_int();
        tb.position = byteArray.read_int();
        tb.temp_id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_sculpture_puton"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_sculpture_puton ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_sculpture_puton"]
    end
    tb.is_success = 0
    tb.group_index = 0
    tb.position = 0
    tb.temp_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.is_success)
    	byteArray.write_int(tb.group_index)
    	byteArray.write_int(tb.position)
    	byteArray.write_int(tb.temp_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.is_success = byteArray.read_int();
        tb.group_index = byteArray.read_int();
        tb.position = byteArray.read_int();
        tb.temp_id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_sculpture_puton"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_sculpture_takeoff ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_sculpture_takeoff"]
    end
    tb.group_index = 0
    tb.position = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.group_index)
    	byteArray.write_int(tb.position)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.group_index = byteArray.read_int();
        tb.position = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_sculpture_takeoff"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_sculpture_takeoff ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_sculpture_takeoff"]
    end
    tb.is_success = 0
    tb.group_index = 0
    tb.position = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.is_success)
    	byteArray.write_int(tb.group_index)
    	byteArray.write_int(tb.position)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.is_success = byteArray.read_int();
        tb.group_index = byteArray.read_int();
        tb.position = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_sculpture_takeoff"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_change_skill_group ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_change_skill_group"]
    end
    tb.group_index = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.group_index)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.group_index = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_change_skill_group"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_change_skill_group ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_change_skill_group"]
    end
    tb.result = 0
    tb.activate_group = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
    	byteArray.write_int(tb.activate_group)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.activate_group = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_change_skill_group"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_sculpture_upgrade ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_sculpture_upgrade"]
    end
    tb.temp_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.temp_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.temp_id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_sculpture_upgrade"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_sculpture_upgrade ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_sculpture_upgrade"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_sculpture_upgrade"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_sculpture_advnace ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_sculpture_advnace"]
    end
    tb.temp_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.temp_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.temp_id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_sculpture_advnace"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_sculpture_advnace ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_sculpture_advnace"]
    end
    tb.result = 0
    tb.new_temp_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
    	byteArray.write_int(tb.new_temp_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.new_temp_id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_sculpture_advnace"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_sculpture_unlock ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_sculpture_unlock"]
    end
    tb.temp_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.temp_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.temp_id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_sculpture_unlock"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_sculpture_unlock ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_sculpture_unlock"]
    end
    tb.result = 0
    tb.temp_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
    	byteArray.write_int(tb.temp_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.temp_id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_sculpture_unlock"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_sculpture_divine ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_sculpture_divine"]
    end
    tb.type = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.type)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.type = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_sculpture_divine"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_sculpture_divine ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_sculpture_divine"]
    end
    tb.result = 0
    tb.reward_list = {}
    tb.type = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        byteArray.write_uint16(#(tb.reward_list))
        for k, v in pairs(tb.reward_list) do
            byteArray = v.encode(byteArray)
        end
    	byteArray.write_int(tb.type)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        local countOfreward_list = byteArray.read_uint16()
        tb.reward_list = {}
        for i = 1, countOfreward_list do
            local temp = reward_item()
            temp.decode(byteArray)
            table.insert(tb.reward_list, temp)
        end
        tb.type = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_sculpture_divine"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_divine_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_divine_info"]
    end
    tb.count = 0
    tb.common_remain_time = 0
    tb.rare_remain_time = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.count)
    	byteArray.write_int(tb.common_remain_time)
    	byteArray.write_int(tb.rare_remain_time)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.count = byteArray.read_int();
        tb.common_remain_time = byteArray.read_int();
        tb.rare_remain_time = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_divine_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_skill_groups_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_skill_groups_info"]
    end
    tb.groups = {}

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.groups))
        for k, v in pairs(tb.groups) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOfgroups = byteArray.read_uint16()
        tb.groups = {}
        for i = 1, countOfgroups do
            local temp = skill_group_item()
            temp.decode(byteArray)
            table.insert(tb.groups, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_skill_groups_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_challenge_other_player ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_challenge_other_player"]
    end
    tb.role_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.role_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.role_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_challenge_other_player"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_challenge_other_player_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_challenge_other_player_result"]
    end
    tb.game_id = 0
    tb.result = 0
    tb.map = {}

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.game_id)
    	byteArray.write_int(tb.result)
        byteArray.write_uint16(#(tb.map))
        for k, v in pairs(tb.map) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.game_id = byteArray.read_uint64();
        tb.result = byteArray.read_int();
        local countOfmap = byteArray.read_uint16()
        tb.map = {}
        for i = 1, countOfmap do
            local temp = game_map()
            temp.decode(byteArray)
            table.insert(tb.map, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_challenge_other_player_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_challenge_settle ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_challenge_settle"]
    end
    tb.game_id = 0
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.game_id)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.game_id = byteArray.read_uint64();
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_challenge_settle"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_challenge_settle ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_challenge_settle"]
    end
    tb.result = 0
    tb.point = 0
    tb.coins = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
    	byteArray.write_int(tb.point)
    	byteArray.write_int(tb.coins)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.point = byteArray.read_int();
        tb.coins = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_challenge_settle"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_be_challenged_times ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_be_challenged_times"]
    end
    tb.times = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.times)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.times = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_be_challenged_times"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_get_be_challenged_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_get_be_challenged_info"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_get_be_challenged_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_challenge_info_list ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_challenge_info_list"]
    end
    tb.infos = {}

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.infos))
        for k, v in pairs(tb.infos) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOfinfos = byteArray.read_uint16()
        tb.infos = {}
        for i = 1, countOfinfos do
            local temp = challenge_info()
            temp.decode(byteArray)
            table.insert(tb.infos, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_challenge_info_list"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_get_challenge_rank ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_get_challenge_rank"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_get_challenge_rank"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_challenge_rank_list ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_challenge_rank_list"]
    end
    tb.infos = {}

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.infos))
        for k, v in pairs(tb.infos) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOfinfos = byteArray.read_uint16()
        tb.infos = {}
        for i = 1, countOfinfos do
            local temp = rank_info()
            temp.decode(byteArray)
            table.insert(tb.infos, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_challenge_rank_list"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_get_can_challenge_role ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_get_can_challenge_role"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_get_can_challenge_role"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_can_challenge_lists ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_can_challenge_lists"]
    end
    tb.infos = {}

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.infos))
        for k, v in pairs(tb.infos) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOfinfos = byteArray.read_uint16()
        tb.infos = {}
        for i = 1, countOfinfos do
            local temp = rank_info()
            temp.decode(byteArray)
            table.insert(tb.infos, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_can_challenge_lists"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_buy_challenge_times ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_buy_challenge_times"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_buy_challenge_times"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_buy_challenge_times_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_buy_challenge_times_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_buy_challenge_times_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_get_challenge_times_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_get_challenge_times_info"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_get_challenge_times_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_challenge_times_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_challenge_times_info"]
    end
    tb.buy_times = 0
    tb.org_times = 0
    tb.play_times = 0
    tb.award_timeleft = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.buy_times)
    	byteArray.write_int(tb.org_times)
    	byteArray.write_int(tb.play_times)
    	byteArray.write_int(tb.award_timeleft)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.buy_times = byteArray.read_int();
        tb.org_times = byteArray.read_int();
        tb.play_times = byteArray.read_int();
        tb.award_timeleft = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_challenge_times_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_assistance_list ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_assistance_list"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_assistance_list"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_assistance_list ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_assistance_list"]
    end
    tb.donors = {}

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.donors))
        for k, v in pairs(tb.donors) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOfdonors = byteArray.read_uint16()
        tb.donors = {}
        for i = 1, countOfdonors do
            local temp = donor()
            temp.decode(byteArray)
            table.insert(tb.donors, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_assistance_list"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_select_donor ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_select_donor"]
    end
    tb.donor_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.donor_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.donor_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_select_donor"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_select_donor_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_select_donor_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_select_donor_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_refresh_assistance_list ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_refresh_assistance_list"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_refresh_assistance_list"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_refresh_assistance_list_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_refresh_assistance_list_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_refresh_assistance_list_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_fresh_lottery_list ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_fresh_lottery_list"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_fresh_lottery_list"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_fresh_lottery_list ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_fresh_lottery_list"]
    end
    tb.lottery_items = {}

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.lottery_items))
        for k, v in pairs(tb.lottery_items) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOflottery_items = byteArray.read_uint16()
        tb.lottery_items = {}
        for i = 1, countOflottery_items do
            local temp = friend_point_lottery_item()
            temp.decode(byteArray)
            table.insert(tb.lottery_items, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_fresh_lottery_list"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_friend_point_lottery ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_friend_point_lottery"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_friend_point_lottery"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_friend_point_lottery_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_friend_point_lottery_result"]
    end
    tb.result = 0
    tb.id = 0
    tb.amount = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
    	byteArray.write_int(tb.id)
    	byteArray.write_int(tb.amount)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.id = byteArray.read_int();
        tb.amount = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_friend_point_lottery_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_assistance_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_assistance_info"]
    end
    tb.lottery_times = 0
    tb.refresh_times = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.lottery_times)
    	byteArray.write_int(tb.refresh_times)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.lottery_times = byteArray.read_int();
        tb.refresh_times = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_assistance_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_role_info_change ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_role_info_change"]
    end
    tb.type = ""
    tb.new_value = 0

    tb.encode = function(byteArray)
    	byteArray.write_string(tb.type)
    	byteArray.write_int(tb.new_value)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.type = byteArray.read_string();
        tb.new_value = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_role_info_change"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_buy_mall_item ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_buy_mall_item"]
    end
    tb.mallitem_id = 0
    tb.buy_times = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.mallitem_id)
    	byteArray.write_int(tb.buy_times)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.mallitem_id = byteArray.read_int();
        tb.buy_times = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_buy_mall_item"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_buy_mall_item_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_buy_mall_item_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_buy_mall_item_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_has_buy_times ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_has_buy_times"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_has_buy_times"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_has_buy_times ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_has_buy_times"]
    end
    tb.buy_info_list = {}

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.buy_info_list))
        for k, v in pairs(tb.buy_info_list) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOfbuy_info_list = byteArray.read_uint16()
        tb.buy_info_list = {}
        for i = 1, countOfbuy_info_list do
            local temp = mall_buy_info()
            temp.decode(byteArray)
            table.insert(tb.buy_info_list, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_has_buy_times"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_add_friend_defuse_msg ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_add_friend_defuse_msg"]
    end
    tb.role_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.role_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.role_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_add_friend_defuse_msg"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_get_challenge_rank_award ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_get_challenge_rank_award"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_get_challenge_rank_award"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_get_challenge_rank_award_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_get_challenge_rank_award_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_get_challenge_rank_award_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_buy_point_mall_item ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_buy_point_mall_item"]
    end
    tb.mallitem_id = 0
    tb.buy_times = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.mallitem_id)
    	byteArray.write_int(tb.buy_times)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.mallitem_id = byteArray.read_int();
        tb.buy_times = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_buy_point_mall_item"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_buy_point_mall_item_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_buy_point_mall_item_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_buy_point_mall_item_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function nofity_continue_login_award_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_nofity_continue_login_award_info"]
    end
    tb.continue_login_days = 0
    tb.daily_award_status = 0
    tb.cumulative_award3_status = 0
    tb.cumulative_award7_status = 0
    tb.cumulative_award15_status = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.continue_login_days)
    	byteArray.write_int(tb.daily_award_status)
    	byteArray.write_int(tb.cumulative_award3_status)
    	byteArray.write_int(tb.cumulative_award7_status)
    	byteArray.write_int(tb.cumulative_award15_status)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.continue_login_days = byteArray.read_int();
        tb.daily_award_status = byteArray.read_int();
        tb.cumulative_award3_status = byteArray.read_int();
        tb.cumulative_award7_status = byteArray.read_int();
        tb.cumulative_award15_status = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_nofity_continue_login_award_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_get_daily_award ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_get_daily_award"]
    end
    tb.type = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.type)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.type = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_get_daily_award"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_get_daily_award_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_get_daily_award_result"]
    end
    tb.type = 0
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.type)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.type = byteArray.read_int();
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_get_daily_award_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_sys_time ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_sys_time"]
    end
    tb.sys_time = {}

    tb.encode = function(byteArray)
        tb.sys_time.encode(byteArray);
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.sys_time = stime();
        tb.sys_time.decode(byteArray);
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_sys_time"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_get_rank_infos ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_get_rank_infos"]
    end
    tb.type = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.type)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.type = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_get_rank_infos"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_rank_infos ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_rank_infos"]
    end
    tb.type = 0
    tb.myrank = 0
    tb.top_hundred = {}

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.type)
    	byteArray.write_int(tb.myrank)
        byteArray.write_uint16(#(tb.top_hundred))
        for k, v in pairs(tb.top_hundred) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.type = byteArray.read_int();
        tb.myrank = byteArray.read_int();
        local countOftop_hundred = byteArray.read_uint16()
        tb.top_hundred = {}
        for i = 1, countOftop_hundred do
            local temp = rank_data()
            temp.decode(byteArray)
            table.insert(tb.top_hundred, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_rank_infos"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_train_match_list ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_train_match_list"]
    end
    tb.list_type = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.list_type)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.list_type = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_train_match_list"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_train_match_list ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_train_match_list"]
    end
    tb.match_list = {}

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.match_list))
        for k, v in pairs(tb.match_list) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOfmatch_list = byteArray.read_uint16()
        tb.match_list = {}
        for i = 1, countOfmatch_list do
            local temp = train_info()
            temp.decode(byteArray)
            table.insert(tb.match_list, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_train_match_list"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_start_train_match ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_start_train_match"]
    end
    tb.role_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.role_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.role_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_start_train_match"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_start_train_match_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_start_train_match_result"]
    end
    tb.game_id = 0
    tb.result = 0
    tb.map = {}

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.game_id)
    	byteArray.write_int(tb.result)
        byteArray.write_uint16(#(tb.map))
        for k, v in pairs(tb.map) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.game_id = byteArray.read_uint64();
        tb.result = byteArray.read_int();
        local countOfmap = byteArray.read_uint16()
        tb.map = {}
        for i = 1, countOfmap do
            local temp = game_map()
            temp.decode(byteArray)
            table.insert(tb.map, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_start_train_match_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_train_match_settle ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_train_match_settle"]
    end
    tb.game_id = 0
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.game_id)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.game_id = byteArray.read_uint64();
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_train_match_settle"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_train_match_settle ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_train_match_settle"]
    end
    tb.result = 0
    tb.point = 0
    tb.honour = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
    	byteArray.write_int(tb.point)
    	byteArray.write_int(tb.honour)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.point = byteArray.read_int();
        tb.honour = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_train_match_settle"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_get_train_match_times_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_get_train_match_times_info"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_get_train_match_times_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_train_match_times_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_train_match_times_info"]
    end
    tb.buy_times = 0
    tb.org_times = 0
    tb.play_times = 0
    tb.success_times = 0
    tb.award_status = 0
    tb.refresh_times = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.buy_times)
    	byteArray.write_int(tb.org_times)
    	byteArray.write_int(tb.play_times)
    	byteArray.write_int(tb.success_times)
    	byteArray.write_int(tb.award_status)
    	byteArray.write_int(tb.refresh_times)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.buy_times = byteArray.read_int();
        tb.org_times = byteArray.read_int();
        tb.play_times = byteArray.read_int();
        tb.success_times = byteArray.read_int();
        tb.award_status = byteArray.read_int();
        tb.refresh_times = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_train_match_times_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_buy_train_match_times ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_buy_train_match_times"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_buy_train_match_times"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_buy_train_match_times_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_buy_train_match_times_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_buy_train_match_times_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_get_train_award ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_get_train_award"]
    end
    tb.type = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.type)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.type = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_get_train_award"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_get_train_award_type ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_get_train_award_type"]
    end
    tb.result = 0
    tb.new_status = 0
    tb.award_id = 0
    tb.amount = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
    	byteArray.write_int(tb.new_status)
    	byteArray.write_int(tb.award_id)
    	byteArray.write_int(tb.amount)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.new_status = byteArray.read_int();
        tb.award_id = byteArray.read_int();
        tb.amount = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_get_train_award_type"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_use_props ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_use_props"]
    end
    tb.inst_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.inst_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.inst_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_use_props"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_use_props_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_use_props_result"]
    end
    tb.result = 0
    tb.reward_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
    	byteArray.write_int(tb.reward_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.reward_id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_use_props_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_benison_list ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_benison_list"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_benison_list"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_benison_list ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_benison_list"]
    end
    tb.benison_list = {}
    tb.benison_status = {}

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.benison_list))
        for k, v in pairs (tb.benison_list) do
            byteArray.write_int(v)
        end
        byteArray.write_uint16(#(tb.benison_status))
        for k, v in pairs (tb.benison_status) do
            byteArray.write_int(v)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOfbenison_list = byteArray.read_uint16()
        tb.benison_list = {}
        for i = 1, countOfbenison_list do
             table.insert(tb.benison_list, byteArray.read_int())
        end
        local countOfbenison_status = byteArray.read_uint16()
        tb.benison_status = {}
        for i = 1, countOfbenison_status do
             table.insert(tb.benison_status, byteArray.read_int())
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_benison_list"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_bless ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_bless"]
    end
    tb.benison_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.benison_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.benison_id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_bless"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_bless_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_bless_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_bless_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_role_bless_buff ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_role_bless_buff"]
    end
    tb.benison_id = 0
    tb.buffs = {}
    tb.time_left = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.benison_id)
        byteArray.write_uint16(#(tb.buffs))
        for k, v in pairs (tb.buffs) do
            byteArray.write_int(v)
        end
    	byteArray.write_int(tb.time_left)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.benison_id = byteArray.read_int();
        local countOfbuffs = byteArray.read_uint16()
        tb.buffs = {}
        for i = 1, countOfbuffs do
             table.insert(tb.buffs, byteArray.read_int())
        end
        tb.time_left = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_role_bless_buff"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_refresh_benison_list ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_refresh_benison_list"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_refresh_benison_list"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_refresh_benison_list_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_refresh_benison_list_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_refresh_benison_list_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_equipment_advance ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_equipment_advance"]
    end
    tb.inst_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.inst_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.inst_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_equipment_advance"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_equipment_advance_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_equipment_advance_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_equipment_advance_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_equipment_exchange ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_equipment_exchange"]
    end
    tb.inst_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.inst_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.inst_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_equipment_exchange"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_equipment_exchange_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_equipment_exchange_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_equipment_exchange_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_equipment_resolve ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_equipment_resolve"]
    end
    tb.inst_id = {}

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.inst_id))
        for k, v in pairs (tb.inst_id) do
            byteArray.write_uint64(v)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOfinst_id = byteArray.read_uint16()
        tb.inst_id = {}
        for i = 1, countOfinst_id do
             table.insert(tb.inst_id, byteArray.read_uint64())
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_equipment_resolve"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_equipment_resolve_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_equipment_resolve_result"]
    end
    tb.result = 0
    tb.errid = 0
    tb.infos = {}

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
    	byteArray.write_uint64(tb.errid)
        byteArray.write_uint16(#(tb.infos))
        for k, v in pairs(tb.infos) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.errid = byteArray.read_uint64();
        local countOfinfos = byteArray.read_uint16()
        tb.infos = {}
        for i = 1, countOfinfos do
            local temp = material_info()
            temp.decode(byteArray)
            table.insert(tb.infos, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_equipment_resolve_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_equipment_recast ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_equipment_recast"]
    end
    tb.inst_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.inst_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.inst_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_equipment_recast"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_equipment_recast_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_equipment_recast_result"]
    end
    tb.result = 0
    tb.new_info = {}

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        tb.new_info.encode(byteArray);
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.new_info = equipmentinfo();
        tb.new_info.decode(byteArray);
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_equipment_recast_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_save_recast_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_save_recast_info"]
    end
    tb.equipment_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.equipment_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.equipment_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_save_recast_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_save_recast_info_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_save_recast_info_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_save_recast_info_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_upgrade_task_rewarded_list ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_upgrade_task_rewarded_list"]
    end
    tb.reward_ids = {}

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.reward_ids))
        for k, v in pairs (tb.reward_ids) do
            byteArray.write_int(v)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOfreward_ids = byteArray.read_uint16()
        tb.reward_ids = {}
        for i = 1, countOfreward_ids do
             table.insert(tb.reward_ids, byteArray.read_int())
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_upgrade_task_rewarded_list"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_upgrade_task_reward ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_upgrade_task_reward"]
    end
    tb.task_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.task_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.task_id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_upgrade_task_reward"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_upgrade_task_reward_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_upgrade_task_reward_result"]
    end
    tb.task_id = 0
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.task_id)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.task_id = byteArray.read_int();
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_upgrade_task_reward_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function ladder_role_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_ladder_role_info"]
    end
    tb.role_id = 0
    tb.data_type = 0
    tb.curHp = 0
    tb.nickname = ""
    tb.battle_power = 0
    tb.type = 0
    tb.level = 0
    tb.battle_prop = {}
    tb.potence_level = 0
    tb.advanced_level = 0
    tb.talent_list = {}

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.role_id)
    	byteArray.write_int(tb.data_type)
    	byteArray.write_int(tb.curHp)
    	byteArray.write_string(tb.nickname)
    	byteArray.write_int(tb.battle_power)
    	byteArray.write_int(tb.type)
    	byteArray.write_int(tb.level)
        tb.battle_prop.encode(byteArray);
    	byteArray.write_int(tb.potence_level)
    	byteArray.write_int(tb.advanced_level)
        byteArray.write_uint16(#(tb.talent_list))
        for k, v in pairs(tb.talent_list) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.role_id = byteArray.read_uint64();
        tb.data_type = byteArray.read_int();
        tb.curHp = byteArray.read_int();
        tb.nickname = byteArray.read_string();
        tb.battle_power = byteArray.read_int();
        tb.type = byteArray.read_int();
        tb.level = byteArray.read_int();
        tb.battle_prop = battle_info();
        tb.battle_prop.decode(byteArray);
        tb.potence_level = byteArray.read_int();
        tb.advanced_level = byteArray.read_int();
        local countOftalent_list = byteArray.read_uint16()
        tb.talent_list = {}
        for i = 1, countOftalent_list do
            local temp = talent()
            temp.decode(byteArray)
            table.insert(tb.talent_list, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_ladder_role_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_ladder_role_list ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_ladder_role_list"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_ladder_role_list"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_ladder_role_list ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_ladder_role_list"]
    end
    tb.teammate = {}
    tb.opponent = {}

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.teammate))
        for k, v in pairs(tb.teammate) do
            byteArray = v.encode(byteArray)
        end
        byteArray.write_uint16(#(tb.opponent))
        for k, v in pairs(tb.opponent) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOfteammate = byteArray.read_uint16()
        tb.teammate = {}
        for i = 1, countOfteammate do
            local temp = ladder_role_info()
            temp.decode(byteArray)
            table.insert(tb.teammate, temp)
        end
        local countOfopponent = byteArray.read_uint16()
        tb.opponent = {}
        for i = 1, countOfopponent do
            local temp = ladder_role_info()
            temp.decode(byteArray)
            table.insert(tb.opponent, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_ladder_role_list"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_ladder_teammate ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_ladder_teammate"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_ladder_teammate"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_req_ladder_teammate_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_req_ladder_teammate_result"]
    end
    tb.teammate_info = {}
    tb.result = 0

    tb.encode = function(byteArray)
        tb.teammate_info.encode(byteArray);
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.teammate_info = ladder_role_info();
        tb.teammate_info.decode(byteArray);
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_req_ladder_teammate_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_reselect_ladder_teammate ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_reselect_ladder_teammate"]
    end
    tb.role_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.role_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.role_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_reselect_ladder_teammate"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_reselect_ladder_teammate_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_reselect_ladder_teammate_result"]
    end
    tb.teammate_info = {}

    tb.encode = function(byteArray)
        tb.teammate_info.encode(byteArray);
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.teammate_info = ladder_role_info();
        tb.teammate_info.decode(byteArray);
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_reselect_ladder_teammate_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_ladder_match_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_ladder_match_info"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_ladder_match_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_ladder_match_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_ladder_match_info"]
    end
    tb.pass_level = 0
    tb.cur_life = 0
    tb.is_failed = 0
    tb.recover_count = 0
    tb.reset_count = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.pass_level)
    	byteArray.write_int(tb.cur_life)
    	byteArray.write_int(tb.is_failed)
    	byteArray.write_int(tb.recover_count)
    	byteArray.write_int(tb.reset_count)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.pass_level = byteArray.read_int();
        tb.cur_life = byteArray.read_int();
        tb.is_failed = byteArray.read_int();
        tb.recover_count = byteArray.read_int();
        tb.reset_count = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_ladder_match_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_ladder_match_battle ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_ladder_match_battle"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_ladder_match_battle"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_ladder_match_battle_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_ladder_match_battle_result"]
    end
    tb.result = 0
    tb.map = {}
    tb.game_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        byteArray.write_uint16(#(tb.map))
        for k, v in pairs(tb.map) do
            byteArray = v.encode(byteArray)
        end
    	byteArray.write_uint64(tb.game_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        local countOfmap = byteArray.read_uint16()
        tb.map = {}
        for i = 1, countOfmap do
            local temp = game_map()
            temp.decode(byteArray)
            table.insert(tb.map, temp)
        end
        tb.game_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_ladder_match_battle_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_settle_ladder_match ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_settle_ladder_match"]
    end
    tb.game_id = 0
    tb.life_info = {}
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.game_id)
        byteArray.write_uint16(#(tb.life_info))
        for k, v in pairs(tb.life_info) do
            byteArray = v.encode(byteArray)
        end
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.game_id = byteArray.read_uint64();
        local countOflife_info = byteArray.read_uint16()
        tb.life_info = {}
        for i = 1, countOflife_info do
            local temp = role_life_info()
            temp.decode(byteArray)
            table.insert(tb.life_info, temp)
        end
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_settle_ladder_match"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_settle_ladder_match ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_settle_ladder_match"]
    end
    tb.result = 0
    tb.reward_ids = {}
    tb.reward_amounts = {}

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        byteArray.write_uint16(#(tb.reward_ids))
        for k, v in pairs (tb.reward_ids) do
            byteArray.write_int(v)
        end
        byteArray.write_uint16(#(tb.reward_amounts))
        for k, v in pairs (tb.reward_amounts) do
            byteArray.write_int(v)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        local countOfreward_ids = byteArray.read_uint16()
        tb.reward_ids = {}
        for i = 1, countOfreward_ids do
             table.insert(tb.reward_ids, byteArray.read_int())
        end
        local countOfreward_amounts = byteArray.read_uint16()
        tb.reward_amounts = {}
        for i = 1, countOfreward_amounts do
             table.insert(tb.reward_amounts, byteArray.read_int())
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_settle_ladder_match"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_reset_ladder_match ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_reset_ladder_match"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_reset_ladder_match"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_reset_ladder_match_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_reset_ladder_match_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_reset_ladder_match_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_recover_teammate_life ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_recover_teammate_life"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_recover_teammate_life"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_recover_teammate_life_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_recover_teammate_life_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_recover_teammate_life_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_online_award_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_online_award_info"]
    end
    tb.total_online_time = 0
    tb.has_get_awards = {}

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.total_online_time)
        byteArray.write_uint16(#(tb.has_get_awards))
        for k, v in pairs (tb.has_get_awards) do
            byteArray.write_int(v)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.total_online_time = byteArray.read_int();
        local countOfhas_get_awards = byteArray.read_uint16()
        tb.has_get_awards = {}
        for i = 1, countOfhas_get_awards do
             table.insert(tb.has_get_awards, byteArray.read_int())
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_online_award_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_get_online_award ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_get_online_award"]
    end
    tb.online_award_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.online_award_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.online_award_id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_get_online_award"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_get_online_award_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_get_online_award_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_get_online_award_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_alchemy_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_alchemy_info"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_alchemy_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_alchemy_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_alchemy_info"]
    end
    tb.nomrmal_count = 0
    tb.remain_normal_second = 0
    tb.advanced_count = 0
    tb.level = 0
    tb.rewarded_list = {}

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.nomrmal_count)
    	byteArray.write_int(tb.remain_normal_second)
    	byteArray.write_int(tb.advanced_count)
    	byteArray.write_int(tb.level)
        byteArray.write_uint16(#(tb.rewarded_list))
        for k, v in pairs (tb.rewarded_list) do
            byteArray.write_int(v)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.nomrmal_count = byteArray.read_int();
        tb.remain_normal_second = byteArray.read_int();
        tb.advanced_count = byteArray.read_int();
        tb.level = byteArray.read_int();
        local countOfrewarded_list = byteArray.read_uint16()
        tb.rewarded_list = {}
        for i = 1, countOfrewarded_list do
             table.insert(tb.rewarded_list, byteArray.read_int())
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_alchemy_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_metallurgy ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_metallurgy"]
    end
    tb.type = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.type)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.type = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_metallurgy"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_metallurgy_reuslt ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_metallurgy_reuslt"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_metallurgy_reuslt"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_alchemy_reward ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_alchemy_reward"]
    end
    tb.type = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.type)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.type = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_alchemy_reward"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_alchemy_reward_reuslt ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_alchemy_reward_reuslt"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_alchemy_reward_reuslt"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_potence_advance ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_potence_advance"]
    end
    tb.is_use_amulet = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.is_use_amulet)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.is_use_amulet = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_potence_advance"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_potence_advance_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_potence_advance_result"]
    end
    tb.result = 0
    tb.potence_level = 0
    tb.advanced_level = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
    	byteArray.write_int(tb.potence_level)
    	byteArray.write_int(tb.advanced_level)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.potence_level = byteArray.read_int();
        tb.advanced_level = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_potence_advance_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_exchange_item ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_exchange_item"]
    end
    tb.exchange_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.exchange_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.exchange_id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_exchange_item"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_exchange_item_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_exchange_item_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_exchange_item_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_has_buy_discount_item_times ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_has_buy_discount_item_times"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_has_buy_discount_item_times"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_has_buy_discount_item_times ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_has_buy_discount_item_times"]
    end
    tb.buy_info_list = {}

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.buy_info_list))
        for k, v in pairs(tb.buy_info_list) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOfbuy_info_list = byteArray.read_uint16()
        tb.buy_info_list = {}
        for i = 1, countOfbuy_info_list do
            local temp = mall_buy_info()
            temp.decode(byteArray)
            table.insert(tb.buy_info_list, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_has_buy_discount_item_times"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_buy_discount_limit_item ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_buy_discount_limit_item"]
    end
    tb.id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_buy_discount_limit_item"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_buy_discount_limit_item_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_buy_discount_limit_item_result"]
    end
    tb.result = 0
    tb.mall_item_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
    	byteArray.write_int(tb.mall_item_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.mall_item_id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_buy_discount_limit_item_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_convert_cdkey ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_convert_cdkey"]
    end
    tb.award_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.award_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.award_id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_convert_cdkey"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_redeem_cdoe_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_redeem_cdoe_result"]
    end
    tb.awards = {}

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.awards))
        for k, v in pairs(tb.awards) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOfawards = byteArray.read_uint16()
        tb.awards = {}
        for i = 1, countOfawards do
            local temp = award_item()
            temp.decode(byteArray)
            table.insert(tb.awards, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_redeem_cdoe_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_email_list ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_email_list"]
    end
    tb.emails = {}

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.emails))
        for k, v in pairs(tb.emails) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOfemails = byteArray.read_uint16()
        tb.emails = {}
        for i = 1, countOfemails do
            local temp = semail()
            temp.decode(byteArray)
            table.insert(tb.emails, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_email_list"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_email_add ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_email_add"]
    end
    tb.new_email = {}

    tb.encode = function(byteArray)
        tb.new_email.encode(byteArray);
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.new_email = semail();
        tb.new_email.decode(byteArray);
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_email_add"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_get_email_attachments ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_get_email_attachments"]
    end
    tb.email_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.email_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.email_id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_get_email_attachments"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_get_email_attachments_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_get_email_attachments_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_get_email_attachments_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_buy_mooncard ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_buy_mooncard"]
    end
    tb.type = 0
    tb.reward_emoney = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.type)
    	byteArray.write_int(tb.reward_emoney)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.type = byteArray.read_int();
        tb.reward_emoney = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_buy_mooncard"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_mooncard_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_mooncard_info"]
    end
    tb.award_status = 0
    tb.days_remain = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.award_status)
    	byteArray.write_int(tb.days_remain)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.award_status = byteArray.read_int();
        tb.days_remain = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_mooncard_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_get_mooncard_daily_award ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_get_mooncard_daily_award"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_get_mooncard_daily_award"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_get_mooncard_daily_award_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_get_mooncard_daily_award_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_get_mooncard_daily_award_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_enter_activity_copy ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_enter_activity_copy"]
    end
    tb.copy_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.copy_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.copy_id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_enter_activity_copy"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_enter_activity_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_enter_activity_result"]
    end
    tb.result = 0
    tb.game_id = 0
    tb.gamemaps = {}

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
    	byteArray.write_uint64(tb.game_id)
        byteArray.write_uint16(#(tb.gamemaps))
        for k, v in pairs(tb.gamemaps) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.game_id = byteArray.read_uint64();
        local countOfgamemaps = byteArray.read_uint16()
        tb.gamemaps = {}
        for i = 1, countOfgamemaps do
            local temp = game_map()
            temp.decode(byteArray)
            table.insert(tb.gamemaps, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_enter_activity_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_settle_activity_copy ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_settle_activity_copy"]
    end
    tb.game_id = 0
    tb.result = 0
    tb.pickup_items = {}
    tb.gold = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.game_id)
    	byteArray.write_int(tb.result)
        byteArray.write_uint16(#(tb.pickup_items))
        for k, v in pairs(tb.pickup_items) do
            byteArray = v.encode(byteArray)
        end
    	byteArray.write_int(tb.gold)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.game_id = byteArray.read_uint64();
        tb.result = byteArray.read_int();
        local countOfpickup_items = byteArray.read_uint16()
        tb.pickup_items = {}
        for i = 1, countOfpickup_items do
            local temp = mons_item()
            temp.decode(byteArray)
            table.insert(tb.pickup_items, temp)
        end
        tb.gold = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_settle_activity_copy"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_settle_activity_copy_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_settle_activity_copy_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_settle_activity_copy_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_activity_copy_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_activity_copy_info"]
    end
    tb.play_times = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.play_times)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.play_times = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_activity_copy_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_verify_invite_code ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_verify_invite_code"]
    end
    tb.code = ""

    tb.encode = function(byteArray)
    	byteArray.write_string(tb.code)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.code = byteArray.read_string();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_verify_invite_code"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_verify_invite_code_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_verify_invite_code_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_verify_invite_code_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_input_invite_code ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_input_invite_code"]
    end
    tb.code = ""

    tb.encode = function(byteArray)
    	byteArray.write_string(tb.code)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.code = byteArray.read_string();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_input_invite_code"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_input_invite_code_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_input_invite_code_result"]
    end
    tb.result = 0
    tb.master = {}

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        tb.master.encode(byteArray);
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.master = master_info();
        tb.master.decode(byteArray);
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_input_invite_code_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_disengage_check ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_disengage_check"]
    end
    tb.type = 0
    tb.role_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.type)
    	byteArray.write_uint64(tb.role_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.type = byteArray.read_int();
        tb.role_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_disengage_check"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_disengage_check_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_disengage_check_result"]
    end
    tb.result = 0
    tb.role_id = 0
    tb.type = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
    	byteArray.write_uint64(tb.role_id)
    	byteArray.write_int(tb.type)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.role_id = byteArray.read_uint64();
        tb.type = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_disengage_check_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_disengage ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_disengage"]
    end
    tb.type = 0
    tb.role_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.type)
    	byteArray.write_uint64(tb.role_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.type = byteArray.read_int();
        tb.role_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_disengage"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_disengage_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_disengage_result"]
    end
    tb.result = 0
    tb.role_id = 0
    tb.type = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
    	byteArray.write_uint64(tb.role_id)
    	byteArray.write_int(tb.type)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.role_id = byteArray.read_uint64();
        tb.type = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_disengage_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_lost_prentice ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_lost_prentice"]
    end
    tb.role_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.role_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.role_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_lost_prentice"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_lost_master ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_lost_master"]
    end
    tb.role_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.role_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.role_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_lost_master"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_master_level_reward ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_master_level_reward"]
    end
    tb.prentice_id = 0
    tb.level = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.prentice_id)
    	byteArray.write_int(tb.level)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.prentice_id = byteArray.read_uint64();
        tb.level = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_master_level_reward"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_master_level_reward_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_master_level_reward_result"]
    end
    tb.result = 0
    tb.prentice_id = 0
    tb.level = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
    	byteArray.write_uint64(tb.prentice_id)
    	byteArray.write_int(tb.level)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.prentice_id = byteArray.read_uint64();
        tb.level = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_master_level_reward_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_prentice_level_reward ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_prentice_level_reward"]
    end
    tb.level = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.level)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.level = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_prentice_level_reward"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_prentice_level_reward_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_prentice_level_reward_result"]
    end
    tb.result = 0
    tb.level = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
    	byteArray.write_int(tb.level)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.level = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_prentice_level_reward_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_master_help ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_master_help"]
    end
    tb.level = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.level)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.level = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_master_help"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_master_help_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_master_help_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_master_help_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_give_help ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_give_help"]
    end
    tb.prentice_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.prentice_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.prentice_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_give_help"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_give_help_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_give_help_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_give_help_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_get_help_reward ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_get_help_reward"]
    end
    tb.level = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.level)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.level = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_get_help_reward"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_get_help_reward_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_get_help_reward_result"]
    end
    tb.result = 0
    tb.level = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
    	byteArray.write_int(tb.level)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.level = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_get_help_reward_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_req_help_from_prentice ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_req_help_from_prentice"]
    end
    tb.prentice_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.prentice_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.prentice_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_req_help_from_prentice"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_give_help_from_master ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_give_help_from_master"]
    end
    tb.master_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.master_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.master_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_give_help_from_master"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_invite_code_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_invite_code_info"]
    end
    tb.master = {}
    tb.prentice_list = {}
    tb.code = ""
    tb.is_new_prentice_got = 0
    tb.rewarded_list = {}

    tb.encode = function(byteArray)
        tb.master.encode(byteArray);
        byteArray.write_uint16(#(tb.prentice_list))
        for k, v in pairs(tb.prentice_list) do
            byteArray = v.encode(byteArray)
        end
    	byteArray.write_string(tb.code)
    	byteArray.write_int(tb.is_new_prentice_got)
        byteArray.write_uint16(#(tb.rewarded_list))
        for k, v in pairs (tb.rewarded_list) do
            byteArray.write_int(v)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.master = master_info();
        tb.master.decode(byteArray);
        local countOfprentice_list = byteArray.read_uint16()
        tb.prentice_list = {}
        for i = 1, countOfprentice_list do
            local temp = prentice_info()
            temp.decode(byteArray)
            table.insert(tb.prentice_list, temp)
        end
        tb.code = byteArray.read_string();
        tb.is_new_prentice_got = byteArray.read_int();
        local countOfrewarded_list = byteArray.read_uint16()
        tb.rewarded_list = {}
        for i = 1, countOfrewarded_list do
             table.insert(tb.rewarded_list, byteArray.read_int())
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_invite_code_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_send_hp ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_send_hp"]
    end
    tb.friend_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.friend_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.friend_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_send_hp"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_send_hp_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_send_hp_result"]
    end
    tb.result = 0
    tb.friend_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
    	byteArray.write_uint64(tb.friend_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.friend_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_send_hp_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_get_hp_help_from_friend ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_get_hp_help_from_friend"]
    end
    tb.friend_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.friend_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.friend_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_get_hp_help_from_friend"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_reward_hp_from_friend ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_reward_hp_from_friend"]
    end
    tb.friend_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.friend_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.friend_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_reward_hp_from_friend"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_reward_hp_from_friend_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_reward_hp_from_friend_result"]
    end
    tb.result = 0
    tb.friend_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
    	byteArray.write_uint64(tb.friend_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.friend_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_reward_hp_from_friend_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_boss_copy_fight_count ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_boss_copy_fight_count"]
    end
    tb.count = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.count)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.count = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_boss_copy_fight_count"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_chat_in_world_channel ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_chat_in_world_channel"]
    end
    tb.msg = ""

    tb.encode = function(byteArray)
    	byteArray.write_string(tb.msg)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.msg = byteArray.read_string();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_chat_in_world_channel"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_chat_in_world_channel_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_chat_in_world_channel_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_chat_in_world_channel_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_world_channel_msg ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_world_channel_msg"]
    end
    tb.speaker_id = 0
    tb.speaker = ""
    tb.msg = ""

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.speaker_id)
    	byteArray.write_string(tb.speaker)
    	byteArray.write_string(tb.msg)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.speaker_id = byteArray.read_uint64();
        tb.speaker = byteArray.read_string();
        tb.msg = byteArray.read_string();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_world_channel_msg"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_my_world_chat_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_my_world_chat_info"]
    end
    tb.speek_times = 0
    tb.extra_times = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.speek_times)
    	byteArray.write_int(tb.extra_times)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.speek_times = byteArray.read_int();
        tb.extra_times = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_my_world_chat_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_get_role_detail_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_get_role_detail_info"]
    end
    tb.role_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.role_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.role_id = byteArray.read_uint64();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_get_role_detail_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_role_detail_info_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_role_detail_info_result"]
    end
    tb.role_id = 0
    tb.nickname = ""
    tb.status = 0
    tb.level = 0
    tb.type = 0
    tb.public = ""
    tb.potence_level = 0
    tb.advanced_level = 0
    tb.sculptures = {}
    tb.equipments = {}
    tb.battle_power = 0
    tb.military_lev = 0
    tb.challenge_rank = 0

    tb.encode = function(byteArray)
    	byteArray.write_uint64(tb.role_id)
    	byteArray.write_string(tb.nickname)
    	byteArray.write_int(tb.status)
    	byteArray.write_int(tb.level)
    	byteArray.write_int(tb.type)
    	byteArray.write_string(tb.public)
    	byteArray.write_int(tb.potence_level)
    	byteArray.write_int(tb.advanced_level)
        byteArray.write_uint16(#(tb.sculptures))
        for k, v in pairs(tb.sculptures) do
            byteArray = v.encode(byteArray)
        end
        byteArray.write_uint16(#(tb.equipments))
        for k, v in pairs(tb.equipments) do
            byteArray = v.encode(byteArray)
        end
    	byteArray.write_int(tb.battle_power)
    	byteArray.write_int(tb.military_lev)
    	byteArray.write_int(tb.challenge_rank)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.role_id = byteArray.read_uint64();
        tb.nickname = byteArray.read_string();
        tb.status = byteArray.read_int();
        tb.level = byteArray.read_int();
        tb.type = byteArray.read_int();
        tb.public = byteArray.read_string();
        tb.potence_level = byteArray.read_int();
        tb.advanced_level = byteArray.read_int();
        local countOfsculptures = byteArray.read_uint16()
        tb.sculptures = {}
        for i = 1, countOfsculptures do
            local temp = sculpture_data()
            temp.decode(byteArray)
            table.insert(tb.sculptures, temp)
        end
        local countOfequipments = byteArray.read_uint16()
        tb.equipments = {}
        for i = 1, countOfequipments do
            local temp = equipmentinfo()
            temp.decode(byteArray)
            table.insert(tb.equipments, temp)
        end
        tb.battle_power = byteArray.read_int();
        tb.military_lev = byteArray.read_int();
        tb.challenge_rank = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_role_detail_info_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_get_talent_active_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_get_talent_active_info"]
    end
    tb.active_talent_ids = {}
    tb.reset_active_hours = 0

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.active_talent_ids))
        for k, v in pairs (tb.active_talent_ids) do
            byteArray.write_int(v)
        end
    	byteArray.write_int(tb.reset_active_hours)
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOfactive_talent_ids = byteArray.read_uint16()
        tb.active_talent_ids = {}
        for i = 1, countOfactive_talent_ids do
             table.insert(tb.active_talent_ids, byteArray.read_int())
        end
        tb.reset_active_hours = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_get_talent_active_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_actived_talent ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_actived_talent"]
    end
    tb.talent_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.talent_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.talent_id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_actived_talent"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_actived_talent ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_actived_talent"]
    end
    tb.is_success = 0
    tb.talent_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.is_success)
    	byteArray.write_int(tb.talent_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.is_success = byteArray.read_int();
        tb.talent_id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_actived_talent"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_reset_talent ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_reset_talent"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_reset_talent"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_reset_talent ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_reset_talent"]
    end
    tb.is_success = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.is_success)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.is_success = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_reset_talent"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_level_up_talent ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_level_up_talent"]
    end
    tb.talent_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.talent_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.talent_id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_level_up_talent"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_level_up_talent ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_level_up_talent"]
    end
    tb.is_success = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.is_success)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.is_success = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_level_up_talent"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_notice_list ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_notice_list"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_notice_list"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_notice_list ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_notice_list"]
    end
    tb.list = {}

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.list))
        for k, v in pairs(tb.list) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOflist = byteArray.read_uint16()
        tb.list = {}
        for i = 1, countOflist do
            local temp = notice_list_item()
            temp.decode(byteArray)
            table.insert(tb.list, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_notice_list"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_notice_item_add ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_notice_item_add"]
    end
    tb.item_info = {}

    tb.encode = function(byteArray)
        tb.item_info.encode(byteArray);
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.item_info = notice_list_item();
        tb.item_info.decode(byteArray);
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_notice_item_add"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_notice_item_del ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_notice_item_del"]
    end
    tb.del_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.del_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.del_id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_notice_item_del"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_notice_item_detail ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_notice_item_detail"]
    end
    tb.id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_notice_item_detail"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_notice_item_detail ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_notice_item_detail"]
    end
    tb.result = 0
    tb.item_info = {}

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        tb.item_info.encode(byteArray);
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.item_info = notice_item_detail();
        tb.item_info.decode(byteArray);
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_notice_item_detail"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_time_limit_reward ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_time_limit_reward"]
    end
    tb.id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_time_limit_reward"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_time_limit_reward ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_time_limit_reward"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_time_limit_reward"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_time_limit_rewarded_list ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_time_limit_rewarded_list"]
    end
    tb.list = {}

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.list))
        for k, v in pairs(tb.list) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOflist = byteArray.read_uint16()
        tb.list = {}
        for i = 1, countOflist do
            local temp = time_limit_rewarded_item()
            temp.decode(byteArray)
            table.insert(tb.list, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_time_limit_rewarded_list"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_activity_list ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_activity_list"]
    end
    tb.list = {}

    tb.encode = function(byteArray)
        byteArray.write_uint16(#(tb.list))
        for k, v in pairs(tb.list) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        local countOflist = byteArray.read_uint16()
        tb.list = {}
        for i = 1, countOflist do
            local temp = activity_item()
            temp.decode(byteArray)
            table.insert(tb.list, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_activity_list"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_act_lottery_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_act_lottery_info"]
    end
    tb.remain_count = 0
    tb.progress_list = {}

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.remain_count)
        byteArray.write_uint16(#(tb.progress_list))
        for k, v in pairs(tb.progress_list) do
            byteArray = v.encode(byteArray)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.remain_count = byteArray.read_int();
        local countOfprogress_list = byteArray.read_uint16()
        tb.progress_list = {}
        for i = 1, countOfprogress_list do
            local temp = lottery_progress_item()
            temp.decode(byteArray)
            table.insert(tb.progress_list, temp)
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_act_lottery_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_act_lottery ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_act_lottery"]
    end

    tb.encode = function(byteArray)
        return byteArray
    end

    tb.decode = function(byteArray)
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_act_lottery"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_act_lottery_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_act_lottery_result"]
    end
    tb.result = 0
    tb.reward_id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
    	byteArray.write_int(tb.reward_id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.reward_id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_act_lottery_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_act_recharge_info ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_act_recharge_info"]
    end
    tb.cur_recharge_count = 0
    tb.rewarded_list = {}

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.cur_recharge_count)
        byteArray.write_uint16(#(tb.rewarded_list))
        for k, v in pairs (tb.rewarded_list) do
            byteArray.write_int(v)
        end
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.cur_recharge_count = byteArray.read_int();
        local countOfrewarded_list = byteArray.read_uint16()
        tb.rewarded_list = {}
        for i = 1, countOfrewarded_list do
             table.insert(tb.rewarded_list, byteArray.read_int())
        end
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_act_recharge_info"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_act_recharge_reward ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_act_recharge_reward"]
    end
    tb.id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_act_recharge_reward"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_act_recharge_reward_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_act_recharge_reward_result"]
    end
    tb.result = 0
    tb.id = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
    	byteArray.write_int(tb.id)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
        tb.id = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_act_recharge_reward_result"])
        return tb.encode(byteArray)
    end

    return tb

end

function req_emoney_2_gold ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_req_emoney_2_gold"]
    end
    tb.emoney = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.emoney)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.emoney = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_req_emoney_2_gold"])
        return tb.encode(byteArray)
    end

    return tb

end

function notify_emoney_2_gold_result ()
    local tb = {}
    tb.getMsgID = function()
        return NetMsgType["msg_notify_emoney_2_gold_result"]
    end
    tb.result = 0

    tb.encode = function(byteArray)
    	byteArray.write_int(tb.result)
        return byteArray
    end

    tb.decode = function(byteArray)
        tb.result = byteArray.read_int();
    end

    tb.build = function(byteArray)
        byteArray.write_uint16(NetMsgType["msg_notify_emoney_2_gold_result"])
        return tb.encode(byteArray)
    end

    return tb

end
