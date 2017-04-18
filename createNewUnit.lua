    function obj:__make_unit_property(utb,ao,cardID,tag,playerName)

        local property  = {}
        -- player name
        local role = ao:get_current_char()
        local name = role:get_name()
        -- player name
        if playerName ~= nil and playerName ~= "" and playerName ~= name then
            property._playerName = playerName
        else
            property._playerName = name
        end

        -- group
        if playerName ~= nil and playerName ~= "" then
            --property._group = self._players[ao] + 1
            local tGroup = nil
            for kao, g in pairs(self._players) do
                local r = kao:get_current_char()
                local n = r:get_name()
                if n == playerName then
                    tGroup = g 
                    break
                end
            end
            if tGroup == nil then tGroup = 99 end
            property._group = tGroup
        else
            property._group = self._players[ao]
        end

        -- unique id
        if cardID == 10000 then
            if tag == nil then
                property._unique_battle_id   = name
            else
                property._unique_battle_id   = "pc_base"
            end
            print("allocate a new battle base with player id : " .. property._unique_battle_id)
        else
            local nname = playerName == nil and name or playerName
            self._unit_count = self._unit_count + 1
            property._unique_battle_id = nname.."#"..tostring(self._unit_count)
            print("allocate a new battle unit with id : " .. property._unique_battle_id)
        end
        -- type id
        property._unique_type_id = cardID
        -- unit name
        property._unit_name = utb.name
        -- type
        property._type = utb.type
        -- race
        property._race = utb.race
        -- rare
        property._rare = utb.rare
        -- cost
        property._cost = utb.cost
        -- hp
        property._hp     = utb.hp
        property._hp_mod = 1.0
        -- attack
        property._atk = utb.atk
        property._atk_mod = 1.0
        property._last_atk_time = 0
        -- attack speed
        property._aspd = utb.aspd
        property._aspd_mod = 1.0
        -- speed
        property._mspeed = utb.mspd
        property._mspeed_mod = 1.0
        -- cable
        property._cable = utb.cable
        -- range
        property._range = utb.range
        property._range_mod = 1.0
        -- area
        property._area  = utb.area
        -- target
        property._target = utb.target
        -- deploy
        property._deploy = utb.deploy
        -- number
        property._number = utb.number

        -- normal attack
        property._normal_attack = utb.normal_attack
        -- skills
        property._skill1 = utb.skill1
        property._skill2 = utb.skill2
        property._skill3 = utb.skill3

        -- model id
        property._model_id = utb.model_id
        -- des
        property._card_atlas_name = utb.card_atlas_name
        -- res
        property._card_sprite_name = utb.card_sprite_name

        -- buffs
        property._buff   = {}
        -- debuffs
        property._debuff = {}
        -- skills
        property._skills = {}
        -- direction info
        property._direct_info = 0
        -- others
        property._others = {}

        return property
    end


    -- add battle unit to battle 
    function obj:try_to_add_new_battle_unit(ao,playerName,unitType,Index,pos,speed)
        -- account id
        local accountID = ao:get_accountid()
        local energy    = self._energy_map[accountID]
        print(" try to add unit with id : ".. unitType )
        -- if energy == nil then
        --	  self._energy_map[accountID] = 20
        --	  energy = self._energy_map[accountID]
        -- end
        if energy ~= nil then
            local flag = unitType < 0 and -1 or 1
            local utb = battle_unit_config.find_battle_unit_by_id(unitType * flag)
            --if utb == nil or utb.cost > energy then
            if utb == nil then
                print(" msg allocate new unit : fail to find unit id ") 
                return 
            end
            local unitCost = math.floor(utb.cost/utb.number)
            if unitType < 0 then unitCost = 0 end
            -- not enough energy
            if energy < unitCost then
                print("not enough energy to allocate a new battle unit with energy : "..energy)
                -- new unit
                local newUnit = self:__make_unit_property(utb,ao,unitType,nil,nil)
                -- direct
                local info   = {}
                local direct = {}
                direct.Time  = -1
                direct.Index = -1
                direct.Pos   = pos
                direct.Speed = speed
                info.UnitID        = "error unit"
                info.UnitType      = -1
                info.LastDirect    = direct
                -- msg
                local msg = gamecore.protocol.make_rsp_battle_add_unit(ao:get_current_char():get_name(),info,energy)
                -- send to all the players
                for x,_ in pairs(self._players) do
                    if x == ao then
                        x:sendMsgToClient(msg)
                    end 
                end
                return
            end
            -- energy left
            energy = energy - unitCost
            self._energy_map[accountID] = energy
            -- new unit
            local newUnit = self:__make_unit_property(utb,ao,unitType,nil,playerName)
            -- direct
            local info   = {}
            info.UnitID        = newUnit._unique_battle_id
            info.UnitType      = unitType

            local direct = {}
            direct.Time  = Time:getUtcTime()
            direct.Index = Index
            direct.Pos   = pos
            direct.Speed = speed

            info.LastDirect    = direct

            newUnit._direct_info = direct
            -- save to local map
            self._battle_units[newUnit._unique_battle_id] = newUnit
            -- msg
            local msg = gamecore.protocol.make_rsp_battle_add_unit(newUnit._playerName,info,energy)
            -- send to all the players
            for a,_ in pairs(self._players) do 
                a:sendMsgToClient(msg) 
            end
            --test invisible
            self:__skill_invisible(newUnit)
            -- test dash
            self:__skill_dash(newUnit)
        else
            print("fail to find this account in this battle ")
        end
    end