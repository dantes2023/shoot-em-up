local Sprite = require("Sprite")
local Item = require("Item")
local ShieldUp = {}
ShieldUp.new = function(options)
    local sprites = {"Power-ups/shield_bronze", "Power-ups/shield_silver", "Power-ups/shield_gold"}
    local level = 1
    if options and options.level then
        if options.level < 1 then
            level = 1
        elseif options.level > #sprites then
            level = #sprites
        else
            level = options.level
        end
    end
    local spriteName = sprites[level]
    local item = Item.new(spriteName)
    local sprite = Sprite.new(spriteName)
    item:insert(sprite)
    item.level = level
    item.name = "sheildup"
    item.duration = level * 8000

    function item:mentalEffect(receiver)
        receiver.openShield(self.duration)
    end

    function item:needKeep(receiver)
        return false
    end
    item:enablePhysics()
    return item
end
return ShieldUp