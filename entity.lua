require('control')
Entity = {components = {}}
PositionComponent = {x = 0, y = 0, r = 0}
DisplayComponent = {image = nil}
ControlComponent = controls
DisplayNode = {display = aDisplayComponent, position = aPositionComponent}
MoveNode = {position = aPositionComponent}

function Entity:addComponent(comp) table.insert(self.components, comp) print('Zucesso') end

Orb = {}
setmetatable(Orb, { __index = Entity })

function Orb:create()
  local orb = {}
  setmetatable(orb,{ __index =  Orb})
  return orb
end

Orb:create():addComponent(1)
