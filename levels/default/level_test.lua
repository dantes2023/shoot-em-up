local gameConfig = require("gameConfig")
local Sublevel = require("Sublevel")
local GravityField = require("GravityField")
local EnemyPlane = require("enemies.EnemyPlane")
local sublevel = Sublevel.new("9999999-009", "test", "test")

function sublevel:show(options)
    local enemy = EnemyPlane.new()
    local field = GravityField.new()

    enemy.x = gameConfig.contentCenterX/2
    enemy.y = 0

    enemy:setScaleLinearVelocity( 0, 150 )
    enemy:rotateByVelocity()

    field.x = gameConfig.contentCenterX
    field.y = gameConfig.contentCenterY

    self:insert(field)
    self:insert(enemy)
end

return sublevel
