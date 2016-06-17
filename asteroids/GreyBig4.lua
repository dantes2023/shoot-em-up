local Asteroid =  require("Asteroid")
local Meteor = {}

Meteor.new = function()
    local asteroid = Asteroid.new("Meteors/Big/8")
    asteroid:addPhysic()
    return asteroid
end

return Meteor