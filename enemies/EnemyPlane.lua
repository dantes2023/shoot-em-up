local Enemy = require("Enemy")
local Sprite = require("Sprite")

local EnemyPlane = {}
EnemyPlane.new = function(options)
    print("new plane")
    local plane = Enemy.new(options)

    plane.centerPart = Sprite.new("Parts/cockpitBlue_5")
    plane.rightPart = Sprite.new("Parts/wingBlue_4")
    plane.leftPart = Sprite.new("Parts/wingBlue_4")
    
    plane:insert(plane.centerPart)
    plane:insert(plane.rightPart)
    plane:insert(plane.leftPart)
    
    plane.leftPart.xScale = - plane.leftPart.xScale;
    plane.leftPart.x = -25
    plane.rightPart.x = 25
    plane.rightPart.y = 8
    plane.leftPart.y = 8
    plane.name = "enemyPlane"
    plane.dir = 270
    plane:addPhysic()

    function plane:split()
        print("split")
        --choose a random angle
        local angle = math.random(360)
        local distance = 50 
        --transition
        transition.to(self.leftPart, {
            time = 1000, 
            x = self.leftPart.x - distance
        })
        transition.to(self.rightPart, {
            time = 1000,
            x = self.rightPart.x + distance
        })
        transition.to(self, {time = 1000, alpha = 0, onComplete = 
            function()
                self:removeSelf()
            end
        })
    end

    function plane:onDead()
        self:split() 
    end

    function plane:onMovePoint(event)
        print("onMovePoint")
        local bullet = Bullet.new("character")
        bullet.x = enemy.x
        bullet.y = enemy.y
        bullet.rotation = enemy.rotation
        local degree = 90 - bullet.rotation
        if degree < 0 then
            degree = degree + 360
        end

        if (degree < 90 and degree > 0) or ( degree > 270 and degree < 360 ) then
            distX = display.contentWidth
            distY = bullet.y - (display.contentWidth - enemy.x) * math.tan(math.rad(degree)) 
        else
            distX = 0
            distY = bullet.y + enemy.x * math.tan(math.rad(degree))
        end
        --stop rotate when shoot, or it's weired
        transition.to(bullet,  {
            x = distX,
            y = distY,
            time = 1000,
            onComplete = function(obj)
                display.remove(bullet)
            end
        })
    end

    return plane
end

return EnemyPlane