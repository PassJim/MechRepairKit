--[===[ Comment this out
function update(dt)
  local delayed = self.queue[self.index]
  if delayed ~= self.state then
    output(delayed)
  end
  self.queue[self.index] = object.getInputNodeLevel(0)

  self.index = self.index % self.queueSize + 1
end

function output(state)
  self.state = state
  object.setOutputNodeLevel(0, state)
  if state then
    animator.setAnimationState("switchState", "on")
  else
    animator.setAnimationState("switchState", "off")
  end
end
]===]

function init()
  object.setInteractive(true)
  if storage.state == nil then
    output(config.getParameter("defaultSwitchState", false))
  else
    output(storage.state)
  end
end

function state()
  return storage.state
end

function onInteraction(args)
  output(not storage.state)
end

function onNpcPlay(npcId)
  onInteraction()
end

function output(state)
  storage.state = state
  if state then
    animator.setAnimationState("switchState", "on")
    if not (config.getParameter("alwaysLit")) then object.setLightColor(config.getParameter("lightColor", {0, 0, 0, 0})) end
    object.setSoundEffectEnabled(true)
    animator.playSound("on");
    object.setAllOutputNodes(true)
  else
    animator.setAnimationState("switchState", "off")
    if not (config.getParameter("alwaysLit")) then object.setLightColor(config.getParameter("lightColorOff", {0, 0, 0})) end
    object.setSoundEffectEnabled(false)
    animator.playSound("off");
    object.setAllOutputNodes(false)
  end
end
-- apparently this is a comment--