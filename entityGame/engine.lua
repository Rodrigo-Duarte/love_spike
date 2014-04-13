Engine = {entities = {}, systems = {}, nodes = {}, drawSystems = {}}

function Engine:addEntity(entity)
  table.insert(self.entities, entity)
  for i,nodeClass in ipairs({RenderNode, ControlNode, MoveNode, CollisionNode}) do
    local node = nodeClass:new(entity)
    if node then
      self.nodes[nodeClass] = self.nodes[nodeClass] or {}
      table.insert(self.nodes[nodeClass], node)
    end
  end
end

function Engine:removeEntity(entity)
  remove(self.entities, entity)
end

function Engine:addSystem(system)
  if getmetatable(system) == RenderSystem then table.insert(self.drawSystems, system)
  else table.insert(self.systems, system) end
end

function Engine:update(dt)
  for i,v in ipairs(self.systems) do
    v:update(dt, self.nodes)
  end
end

function Engine:draw()
  for i,v in ipairs(self.drawSystems) do
    v:update(dt, self.nodes)
  end
end
