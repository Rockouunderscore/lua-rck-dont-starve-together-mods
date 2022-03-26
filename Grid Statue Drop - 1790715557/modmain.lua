--All code is from eXiGe

local ACTIONS = GLOBAL.ACTIONS
local BufferedAction = GLOBAL.BufferedAction

AddComponentPostInit("inventory", function(self)
    local InventoryDropItemFromInvTile = self.DropItemFromInvTile
    self.DropItemFromInvTile = function(self, item, single)
        if not item.components.inventoryitem.cangoincontainer then
            local player = self.inst
            local playercontroller = player.components.playercontroller
            if not player.sg:HasStateTag("busy") and self:CanAccessItem(item) and playercontroller then
                local pos = playercontroller:GetRemotePredictPosition() or player:GetPosition()
                pos.x = math.floor(pos.x) + 0.5
                pos.z = math.floor(pos.z) + 0.5
                local act = BufferedAction(player, nil, ACTIONS.DROP, item, pos)
                player.components.locomotor:PushAction(act, true)
            end
        else
            InventoryDropItemFromInvTile(self, item, single)
        end
    end
end)